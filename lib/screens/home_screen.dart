import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/alumno_provider.dart';
import 'package:notes_crud_local_app/screens/create_alumno_screen.dart';
import 'package:notes_crud_local_app/screens/list_alumno_screen.dart';
import 'package:provider/provider.dart';

import '../providers/actual_option_provider.dart';
import '../widgets/custom_navigatorbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Alumnos")),
        ),
        body: _HomeScreenBody(),
        bottomNavigationBar: const CustomNavigatorBar());
  }
}

class _HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context);

    int selectedOption = actualOptionProvider.selectedOption;

    switch (selectedOption) {
      case 0:
        return const ListAlumnoScreen();
      case 1:
        return const CreateAlumnoScreen();
      default:
        return const ListAlumnoScreen();
    }
  }
}
