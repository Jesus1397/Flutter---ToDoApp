import 'package:get/get.dart';
import 'package:flutter_todo_getx/services/database.dart';
import 'package:flutter_todo_getx/models/todo_model.dart';

class ToDoController extends GetxController {
  Rxn<List<ToDo>> toDosList = Rxn<List<ToDo>>();
  List<ToDo> get toDos => toDosList.value;

  @override
  void onInit() {
    super.onInit();
    toDosList.bindStream(Database().toDoStream());
  }
}
