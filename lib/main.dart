import 'package:flutter/material.dart';
import 'package:flutter_todo_app_assignement/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      home: const TodoList(title: 'TODO App'),
    );
  }
}
