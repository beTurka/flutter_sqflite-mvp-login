import 'package:flutter/material.dart';
import 'package:sqflite_mvp_login/pages/home_page.dart';
import 'package:sqflite_mvp_login/pages/login/login_page.dart';
void main () => runApp(new MyApp());

final routes ={
  '/login': (BuildContext context) => new LoginPage(),
  '/login': (BuildContext context) => new HomePage(),
  '/': (BuildContext context) => new LoginPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sqflite app',
      theme: new ThemeData(primarySwatch: Colors.teal),
      routes: routes,
    );
  }
}