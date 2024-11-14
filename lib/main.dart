


import 'package:database_hive/database/model/todo_model.dart';
import 'package:database_hive/screens/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
late final Box<TodoModel> todoBox ;
void main() async{
  
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
// Box
todoBox =  await Hive.openBox<TodoModel>("todoBox");

 runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(
      scaffoldBackgroundColor: const Color.fromARGB(255, 1, 33, 63)),home: ScreenHome(),);
  }
}