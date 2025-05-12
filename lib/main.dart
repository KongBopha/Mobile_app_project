import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/model/categoriesprovider.dart';
import 'package:task_manager_app/model/taskprovider.dart';
import 'package:task_manager_app/starterscreen.dart';

 void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
     home: const Starterscreen(),
    );
  }
}
 