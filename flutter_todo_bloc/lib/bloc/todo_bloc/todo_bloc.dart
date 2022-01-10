import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_bloc/models/todo_model.dart';
import 'package:meta/meta.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(ToDoState());

  @override
  Stream<ToDoState> mapEventToState(
    ToDoEvent event,
  ) async* {
    if (event is GetToDoList) {
      yield* _getToDoList(state);
    } else if (event is AddToDos) {
      yield* _addToDo(state, event.content);
    } else if (event is UpdateToDos) {
      yield* _updateToDo(state, event.toDo);
    } else if (event is DeleteToDos) {
      yield* _deleteToDo(state, event.id);
    }
  }
}

Stream<ToDoState> _getToDoList(ToDoState state) async* {
  List<QueryDocumentSnapshot> toDoList = [];
  List<ToDo> list = [];

  QuerySnapshot getDocs = await FirebaseFirestore.instance
      .collection("todos")
      .orderBy("dateCreated", descending: true)
      .get();

  toDoList = getDocs.docs;

  toDoList.forEach((QueryDocumentSnapshot element) {
    return list.add(ToDo.fromDocumentSnapshot(element));
  });
  print(' === Get ToDos === ');
  print(state.copyWith(toDosList: list).toDosList.length);
  yield state.copyWith(toDosList: list);
}

Stream<ToDoState> _addToDo(ToDoState state, String content) async* {
  try {
    await FirebaseFirestore.instance.collection('todos').add({
      'content': content,
      'dateCreated': Timestamp.now(),
      'done': false,
    });
    print('add');
    yield* _getToDoList(state);
  } catch (e) {
    rethrow;
  }
}

Stream<ToDoState> _updateToDo(ToDoState state, ToDo toDo) async* {
  try {
    await FirebaseFirestore.instance
        .collection('todos')
        .doc(toDo.todoId)
        .update({'done': !toDo.done});
    print('update');

    yield* _getToDoList(state);
  } catch (e) {
    rethrow;
  }
}

Stream<ToDoState> _deleteToDo(ToDoState state, String id) async* {
  try {
    await FirebaseFirestore.instance.collection('todos').doc(id).delete();
    print('delete');
    yield* _getToDoList(state);
  } catch (e) {
    rethrow;
  }
}
