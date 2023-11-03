
import 'dart:convert';

Alumno noteFromJson(String str) => Alumno.fromJson(json.decode(str));

String noteToJson(Alumno data) => json.encode(data.toJson());
class Alumno {
  int? id;
  String nombre;
  String edad;

  Alumno({
    this.id,
    required this.nombre,
    required this.edad,
  });

  factory Alumno.fromJson(Map<String, dynamic> json) => Alumno(
        id: json["id"],
        nombre: json["nombre"],
        edad: json["edad"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "edad": edad,
      };
}