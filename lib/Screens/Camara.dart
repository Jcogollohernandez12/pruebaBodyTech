import 'package:flutter/material.dart';

class CamaraScreen extends StatefulWidget {
  const CamaraScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CamaraScreen> createState() => _CamaraScreenState();
}

class _CamaraScreenState extends State<CamaraScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _botonFoto(),
        const Positioned(
          top: 100,
          left: 20,
          child: Text(
            'No se tomo ninguna foto',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }

//metodo que crea el boton
  Widget _botonFoto() {
    return Positioned(
      top: 10,
      left: 60,
      child: Container(
        margin: const EdgeInsets.all(25),
        child: OutlinedButton.icon(
          icon: const Icon(
            Icons.camera_alt,
            color: Colors.amber,
          ),
          clipBehavior: Clip.none,
          autofocus: true,
          label: const Text(
            "Tomar una foto",
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
