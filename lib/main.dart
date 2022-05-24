import 'package:flutter/material.dart';
import '/login/login.dart';
import 'app.dart';

void main() {
  runApp(App(
    loginRepository: LoginRepository(),
  ));
}