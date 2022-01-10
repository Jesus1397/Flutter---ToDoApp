import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/bloc/themeChange_bloc/themechange_bloc.dart';
import 'package:flutter_todo_bloc/bloc/todo_bloc/todo_bloc.dart';
import 'package:flutter_todo_bloc/models/todo_model.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _textCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    onInit() {
      BlocProvider.of<ToDoBloc>(context).add(
        GetToDoList(),
      );
    }

    onInit();

    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo - Bloc'),
        centerTitle: true,
        actions: [
          IconThemeWidget(),
        ],
      ),
      body: Container(
        child: BlocBuilder<ToDoBloc, ToDoState>(
          builder: (context, state) {
            return Container(
              child: ListView.builder(
                itemCount: state.copyWith().toDosList.length,
                itemBuilder: (_, int index) {
                  var item = state.copyWith().toDosList[index];
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
                                  BlocProvider.of<ToDoBloc>(context).add(
                                    DeleteToDos(id: item.todoId),
                                  );
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
                      BlocProvider.of<ToDoBloc>(context).add(
                        AddToDos(content: _textCtrl.text),
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
          BlocProvider.of<ToDoBloc>(context).add(
            UpdateToDos(toDo: toDo),
          );
        },
      ),
    );
  }
}

class IconThemeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeBloc = BlocProvider.of<ThemeChangeBloc>(context);
    return IconButton(
      icon: Icon(
        themeBloc.state.theme == ThemeData.light()
            ? Icons.wb_sunny
            : Icons.nights_stay,
      ),
      onPressed: () {
        themeBloc.add(ChangeCurrentTheme());
      },
    );
  }
}
