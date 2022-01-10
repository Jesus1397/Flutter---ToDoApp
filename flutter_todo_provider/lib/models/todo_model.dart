import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  String todoId;
  String content;
  Timestamp dateCreated;
  bool done;

  ToDo(
    this.todoId,
    this.content,
    this.dateCreated,
    this.done,
  );

  ToDo.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    todoId = documentSnapshot.id;
    content = documentSnapshot.get('content');
    dateCreated = documentSnapshot.get("dateCreated");
    done = documentSnapshot.get("done");
  }
}
