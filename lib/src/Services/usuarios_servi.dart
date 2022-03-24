import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:prueba2/src/Models/models.dart';
import 'package:http/http.dart' as http;

class UsuariosService extends ChangeNotifier {
  final String _baseUrl =
      'jsonplaceholder.typicode.com'; //referencia a mi bas de datos
  final List<Usuarios> usuarios =
      []; // variable para contener temporal los usuarios

  bool cargando = false;

  UsuariosService() {
    cargarUsuarios(); //se carga los usuarios registrados
  }

  //metodo para cargar un usuarios desde la base de datos
  Future cargarUsuarios() async {
    cargando = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'posts');
    final respuesta = await http.get(url);
    var tem = respuesta.body.trim();
    final List<dynamic> usuariosMap = json.decode(tem);

    for (var element in usuariosMap) {
      final usuariosTem = Usuarios.fromMap(element);
      usuarios.add(usuariosTem); //agrega a la lista de productos
    }
    /* usuariosMap.forEach((key, value) {
      final usuariosTem = Usuarios.fromMap(value.toMap());
      usuariosTem.id = key as int; // convierte a string
      usuarios.add(usuariosTem); //agrega a la lista de productos
    });*/

    cargando = false;
    notifyListeners();

    return usuarios;
  }
}
