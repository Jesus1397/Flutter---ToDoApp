import 'package:flutter/material.dart';
import 'package:flutter_todo_getx/pages/error_pager.dart';
import 'package:flutter_todo_getx/services/authentication.dart';
import 'package:get/get.dart';

import 'home_page.dart';

class AuthWrapperPage extends StatelessWidget {
  final authCtrl = FirebaseAuthCtrl();
  @override
  Widget build(BuildContext context) {
    authCtrl.signInFirebase(
      email: 'test@gmail.com',
      password: '123456',
    );
    return Obx(
      () {
        if (11 == 100) {
          return HomePage();
        }
        return ErrorPage();
      },
    );
  }
}
