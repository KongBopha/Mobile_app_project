import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/model/categoriesprovider.dart';
import 'package:task_manager_app/model/taskprovider.dart';
import 'package:task_manager_app/starterscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => CategoriesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Starterscreen(),
      ),
    );
  }
}
