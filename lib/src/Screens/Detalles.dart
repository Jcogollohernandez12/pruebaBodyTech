import 'package:flutter/material.dart';

import '../Models/models.dart';
import '../Widgets/widget.dart';

class DetallesUsuariosScreen extends StatefulWidget {
  const DetallesUsuariosScreen({
    Key? key,
    required this.comprobar,
    required this.usuario,
  }) : super(key: key);

  final VoidCallback
      comprobar; //variable para implementar el metodo que me va atraer el usuario a mostrar detalles
  final Usuarios usuario;

  @override
  State<DetallesUsuariosScreen> createState() => _DetallesUsuariosScreenState();
}

class _DetallesUsuariosScreenState extends State<DetallesUsuariosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _contenidoDetalles(context),
      ),
    );
  }

  Widget _contenidoDetalles(BuildContext context) {
    return Column(
      children: [
        SafeArea(
            child:
                Text('Detalles Usuarios :' + widget.usuario.userId.toString())),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: _contenido(context),
          ),
        ),
      ],
    );
  }

//metodo para agregar foto y preferencias y nombre al contenido detalles
  Widget _contenido(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(children: [
          Imagen(
              'https://res.cloudinary.com/restaurante/image/upload/v1647030845/d9lvsvzdfeiqij6du8dx.jpg'),
          Positioned(
              top: 10,
              child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios_new,
                      size: 40, color: Colors.black))),
        ]),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              'ID : ',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.usuario.id.toString(),
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'UserId : ',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.usuario.userId.toString(),
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.indigo),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Text(
          widget.usuario.title,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: const Color.fromARGB(255, 250, 135, 3),
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15),
        Text(
          widget.usuario.body,
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

//para imprementar un metodo en la clase de detalles
  void metododetalles() {
    setState(() {});
    widget
        .comprobar(); //metodo implemetado en grocery_catalogo.dart para comprobar un productoe y enviarlo al carrito
    Navigator.of(context).pop();
  }
}
