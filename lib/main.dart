import 'package:flutter/material.dart';
import 'package:todo_app/home.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      title: "Todo's App",
      theme: ThemeData(primaryColor: Colors.teal)));
