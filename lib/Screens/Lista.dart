import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba2/Models/models.dart';
import 'package:prueba2/Services/services.dart';

import 'screens.dart';

class ListaUsuariosScreen extends StatelessWidget {
  const ListaUsuariosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lista = Provider.of<UsuariosService>(context);
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final userTemp = lista.usuarios[index];
          return GestureDetector(
            child: ListTile(
              title: Text(userTemp.title),
              onTap: () {
                _rutaPag(context, userTemp);
              },
            ),
          );
        },
        itemCount: lista.usuarios.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            thickness: 0.3,
            color: Color.fromARGB(255, 252, 123, 3),
          );
        },
      ),
    );
  }

  //metodo para crear la ruta del usuario
  void _rutaPag(BuildContext context, Usuarios usuario) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, _) {
          return FadeTransition(
            opacity: animation,
            child: DetallesUsuariosScreen(
              comprobar: () {
                //si quiero impemetar un metodo de lado de detalles del usuario
              },
              usuario: usuario,
            ),
          );
        },
      ),
    );
  }
}
