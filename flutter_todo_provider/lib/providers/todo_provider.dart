import 'package:flutter/material.dart';
import 'package:flutter_todo_provider/models/todo_model.dart';

class ToDoProvider extends ChangeNotifier {
  List<ToDo> _toDoList = [];

  ToDoProvider();

  List<ToDo> get getToDoList => _toDoList;

  set setToDoList(List<ToDo> newToDoList) {
    _toDoList = newToDoList;
    notifyListeners();
  }
}
