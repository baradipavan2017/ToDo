import 'package:flutter/material.dart';
import 'package:todo_1/screens/add_task.dart';

import 'screens/todo_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TO-DO',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: ToDoListScreen(),
      routes: {
        AddTask.routeName: (ctx) => AddTask(),
      },
    );
  }
}
