import 'package:flutter/material.dart';

import '../models/alumno_model.dart';
import 'db_provider.dart';

class AlumnoProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String createOrUpdate = 'create';
  int? id;
  String nombre = '';
  String edad = '';

  bool _isLoading = false;
  List<Alumno> alumno = [];

  bool get isLoading => _isLoading;

  set isLoading(bool opc) {
    _isLoading = opc;
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  addAlumno() async {
    final Alumno note = Alumno(nombre: nombre, edad: edad);

    final id = await DBProvider.db.newAlumno(note);

    note.id = id;

    alumno.add(note);

    notifyListeners();
  }

  loadAlumno() async {
    final List<Alumno> alumno = await DBProvider.db.getAllAlumno();
    this.alumno = [...alumno];
    notifyListeners();
  }

  updateAlumno() async {
    final note = Alumno(id: id, nombre: nombre, edad: edad);
    final res = await DBProvider.db.updateAlumno(note);
    loadAlumno();
  }

  deleteAlumnoById(int id) async {
    final res = await DBProvider.db.deleteAlumno(id);
    loadAlumno();
  }



  assignDataWithAlumno(Alumno alumno) {
    id = alumno.id;
    nombre = alumno.nombre;
    edad = alumno.edad;
  }

  resetAlumnoData() {
    id = null;
    nombre = '';
    edad = '';
    createOrUpdate = 'create';
  }
}
