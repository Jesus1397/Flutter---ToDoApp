part of 'todo_bloc.dart';

@immutable
abstract class ToDoEvent {}

class GetToDoList extends ToDoEvent {}

class AddToDos extends ToDoEvent {
  final String content;

  AddToDos({@required this.content});
}

class UpdateToDos extends ToDoEvent {
  final ToDo toDo;

  UpdateToDos({@required this.toDo});
}

class DeleteToDos extends ToDoEvent {
  final String id;

  DeleteToDos({@required this.id});
}
