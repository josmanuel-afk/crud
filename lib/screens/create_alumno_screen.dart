import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option_provider.dart';
import 'package:provider/provider.dart';

import '../providers/alumno_provider.dart';

class CreateAlumnoScreen extends StatelessWidget {
  const CreateAlumnoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CreateForm();
  }
}

class _CreateForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AlumnoProvider notesProvider = Provider.of<AlumnoProvider>(context);
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context, listen: false);
    return Form(
      key: notesProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            initialValue: notesProvider.nombre,
            decoration: const InputDecoration(
                hintText: 'escribiendo...',
                labelText: 'nombre',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
            onChanged: (value) => notesProvider.nombre = value,
            validator: (value) {
              return value != '' ? null : 'El campo no debe estar vacío';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            initialValue: notesProvider.edad,
            // keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'escribiendo...',
              labelText: 'Edad',
            ),
            onChanged: (value) => notesProvider.edad = value,
            validator: (value) {
              return value != "" ? null : 'El campo no puede estar vacío';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            onPressed: notesProvider.isLoading
                ? null
                : () {
                    //Quitar teclado al terminar
                    FocusScope.of(context).unfocus();

                    if (!notesProvider.isValidForm()) return;

                    if (notesProvider.createOrUpdate == 'create') {
                      notesProvider.addAlumno();
                    } else {
                      notesProvider.updateAlumno();
                    }
                    notesProvider.resetNoteData();
                    notesProvider.isLoading = false;
                    actualOptionProvider.selectedOption = 0;
                  },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  notesProvider.isLoading ? 'Espere' : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}

