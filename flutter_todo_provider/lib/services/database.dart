import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_provider/models/todo_model.dart';

class Database {
  var _firebase = FirebaseFirestore.instance;

  Stream<List<ToDo>> toDoStream() {
    return _firebase
        .collection("todos")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map(
          (QuerySnapshot query) => query.docs
              .map(
                (doc) => ToDo.fromDocumentSnapshot(doc),
              )
              .toList(),
        );
  }

  Future<List<QueryDocumentSnapshot>> toDoList() async {
    List<QueryDocumentSnapshot> toDoList = [];

    QuerySnapshot getDocs = await _firebase
        .collection("todos")
        .orderBy("dateCreated", descending: true)
        .get();

    toDoList = getDocs.docs;
    return toDoList;
  }

  Future<String> addToDo({String content}) async {
    try {
      await _firebase.collection('todos').add({
        'content': content,
        'dateCreated': Timestamp.now(),
        'done': false,
      });
      return '👌 Ok ';
    } catch (e) {
      print('🛑 F');
      rethrow;
    }
  }

  Future<String> updateToDo({ToDo toDo}) async {
    try {
      await _firebase
          .collection('todos')
          .doc(toDo.todoId)
          .update({'done': !toDo.done});
      return '👌 Ok ';
    } catch (e) {
      print('🛑 F');
      rethrow;
    }
  }

  Future<String> deleteToDo({String id}) async {
    try {
      await _firebase.collection('todos').doc(id).delete();
      return '👌 Ok ';
    } catch (e) {
      print('🛑 F');
      rethrow;
    }
  }
}
