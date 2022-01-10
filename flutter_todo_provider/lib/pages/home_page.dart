import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_provider/models/todo_model.dart';
import 'package:flutter_todo_provider/providers/todo_provider.dart';
import 'package:flutter_todo_provider/services/database.dart';
import 'package:flutter_todo_provider/providers/theme_provider.dart';

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _textCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var toDo = Provider.of<ToDoProvider>(context);

    onInit() async {
      var aux = await Database().toDoList();
      List<ToDo> list = [];
      aux.forEach((QueryDocumentSnapshot element) {
        return list.add(ToDo.fromDocumentSnapshot(element));
      });
      toDo.setToDoList = list;
    }

    onInit();

    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo - Provider'),
        centerTitle: true,
        actions: [
          IconThemeWidget(),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: toDo.getToDoList.length,
          itemBuilder: (_, int index) {
            var item = toDo.getToDoList[index];
            return GestureDetector(
              child: ToDoItemWidget(toDo: item),
              onLongPress: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Delete Item ?',
                        textAlign: TextAlign.center,
                      ),
                      content: SingleChildScrollView(
                        child: Text(''),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Confirm'),
                          onPressed: () {
                            Database().deleteToDo(id: item.todoId);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _textCtrl.clear();
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Add Item',
                  textAlign: TextAlign.center,
                ),
                content: SingleChildScrollView(
                  child: TextField(
                    controller: _textCtrl,
                    decoration: InputDecoration(
                      hintText: 'Task',
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      _textCtrl.clear();
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Confirm'),
                    onPressed: () {
                      Database().addToDo(
                        content: _textCtrl.text.trim(),
                      );
                      _textCtrl.clear();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
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

class IconThemeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeChangeProvider>(context);

    return IconButton(
      icon: Icon(
        Icons.nights_stay,
      ),
      onPressed: () {
        if (themeProvider.getTheme == ThemeData.dark()) {
          themeProvider.setTheme = ThemeData.light();
        } else if (themeProvider.getTheme == ThemeData.light()) {
          themeProvider.setTheme = ThemeData.dark();
        }
      },
    );
  }
}
