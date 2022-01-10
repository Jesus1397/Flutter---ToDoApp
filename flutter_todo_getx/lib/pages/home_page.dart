import 'package:flutter/material.dart';
import 'package:flutter_todo_getx/controllers/todo_controller.dart';
import 'package:flutter_todo_getx/models/todo_model.dart';
import 'package:flutter_todo_getx/services/authentication.dart';
import 'package:flutter_todo_getx/services/database.dart';
import 'package:get/get.dart';

class HomePage extends GetWidget<ToDoController> {
  final TextEditingController _textCtrl = TextEditingController();
  final authCtrl = FirebaseAuthCtrl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo - GetX'),
        centerTitle: true,
        actions: [
          IconThemeWidget(),
        ],
      ),
      body: Obx(
        () {
          if (controller != null && controller.toDos != null) {
            return Container(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                itemCount: controller.toDos.length,
                itemBuilder: (_, index) {
                  var item = controller.toDos[index];
                  return GestureDetector(
                    child: ToDoItemWidget(
                      toDo: item,
                    ),
                    onLongPress: () {
                      Get.defaultDialog(
                        title: 'Delete Item ?',
                        middleText: '',
                        textConfirm: 'Confirm',
                        textCancel: 'Cancel',
                        onConfirm: () {
                          Database().deleteToDo(id: item.todoId);
                          _textCtrl.clear();
                          Get.back();
                        },
                        onCancel: () {
                          _textCtrl.clear();
                        },
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return Center(child: Text("Loading..."));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _textCtrl.clear();
          Get.defaultDialog(
            title: 'Add Item',
            textConfirm: 'Confirm',
            textCancel: 'Cancel',
            content: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _textCtrl,
                decoration: InputDecoration(
                  hintText: 'Task',
                ),
              ),
            ),
            confirm: Text(
              'Confirm',
              style: TextStyle(),
            ),
            cancel: Text(
              'Cancel',
              style: TextStyle(),
            ),
            onConfirm: () {
              Database().addToDo(content: _textCtrl.text);
              _textCtrl.clear();
              Get.back();
            },
            onCancel: () {
              _textCtrl.clear();
            },
            radius: 0.0,
          );
        },
      ),
    );
  }
}

class ToDoItemWidget extends StatelessWidget {
  final ToDo toDo;

  const ToDoItemWidget({
    Key key,
    @required this.toDo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: CheckboxListTile(
        value: toDo.done,
        title: Text(
          toDo.content,
        ),
        onChanged: (newValue) {
          Database().updateToDo(
            toDo: toDo,
          );
        },
      ),
    );
  }
}

class IconThemeWidget extends StatefulWidget {
  @override
  _IconThemeWidgetState createState() => _IconThemeWidgetState();
}

class _IconThemeWidgetState extends State<IconThemeWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Get.isDarkMode ? Icons.nights_stay : Icons.wb_sunny_rounded,
      ),
      onPressed: () {
        setState(() {});
        Get.isDarkMode
            ? Get.changeTheme(ThemeData.light())
            : Get.changeTheme(ThemeData.dark());
      },
    );
  }
}
