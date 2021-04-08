import 'package:flutter/material.dart';


import 'screens/todo_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TO-DO',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: ToDoListScreen(),
      
    );
  }
}
