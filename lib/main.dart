import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option_provider.dart';
import 'package:notes_crud_local_app/providers/db_provider.dart';
import 'package:notes_crud_local_app/providers/alumno_provider.dart';
import 'package:notes_crud_local_app/screens/home_screen.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DBProvider.db.database;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ActualOptionProvider()),
          ChangeNotifierProvider(create: (_) => AlumnoProvider())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Crud',
            initialRoute: "main",
            routes: {'main': (_) => HomeScreen()}));
  }
}
