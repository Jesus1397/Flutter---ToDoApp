part of 'todo_bloc.dart';

class ToDoState {
  final List<ToDo> toDosList;

  ToDoState({
    this.toDosList = const [],
  });

  ToDoState copyWith({
    List<ToDo> toDosList,
  }) =>
      ToDoState(toDosList: toDosList ?? this.toDosList);
}
