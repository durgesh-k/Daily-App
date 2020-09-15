import 'package:News_App/loginRegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:News_App/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Application',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.amber[800],
        ),
        home: LoginRegisterPage());
  }
}
