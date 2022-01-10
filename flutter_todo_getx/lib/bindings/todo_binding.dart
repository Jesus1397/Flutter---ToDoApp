import 'package:get/get.dart';
import 'package:flutter_todo_getx/controllers/todo_controller.dart';

class ToDoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ToDoController());
  }
}
