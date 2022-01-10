import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseAuthCtrl extends GetxController {
  var _user = Rxn<User>();
  var _loginFirebase = false.obs;

  User get getUser => this._user.value;
  bool get loginFirebase => this._loginFirebase.value;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  @override
  void onClose() {
    _user.close();
    super.onClose();
  }

  Future<bool> signInFirebase({
    @required String email,
    @required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _loginFirebase.value = true;
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      print('🛑 F');
      return false;
    }
  }

  Future<bool> signUpFirebase(
      {@required String email, @required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      print('🛑 F');
      return false;
    }
  }

  Future<bool> logOutFirebase() async {
    try {
      await FirebaseAuth.instance.signOut();
      _loginFirebase.value = false;
      return true;
    } catch (e) {
      print('🛑 F');
      return false;
    }
  }
}
