import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option_provider.dart';
import 'package:notes_crud_local_app/providers/alumno_provider.dart';
import 'package:provider/provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  const CustomNavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context);
    final AlumnoProvider notesProvider = Provider.of(context, listen: false);
    final currentIndex = actualOptionProvider.selectedOption;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int i) {
        if(i == 1){
          notesProvider.resetNoteData();
        }
        actualOptionProvider.selectedOption = i;
      },
      //Items
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.list), label: "Listar alumnos"),
        BottomNavigationBarItem(
            icon: Icon(Icons.post_add_rounded), label: "Crear alumno")
      ],
    );
  }
}
