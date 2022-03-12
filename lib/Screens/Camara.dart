import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CamaraScreen extends StatefulWidget {
  const CamaraScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CamaraScreen> createState() => _CamaraScreenState();
}

class _CamaraScreenState extends State<CamaraScreen> {
  String urlimagen = '';
  List<XFile>? _imageFileList;
  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _botonFoto(),
        Positioned(
          top: 100,
          left: 20,
          child: SizedBox(
            height: 600,
            width: 380,
            child: Card(
              child: image(),
            ),
          ),
        ),
      ],
    );
  }

  Widget image() {
    if (_imageFileList != null) {
      return Image.file(
        File(_imageFileList![0].path),
        fit: BoxFit.cover,
      );
    }
    return const Text(
      'No se tomo ninguna foto',
      style: TextStyle(fontSize: 20),
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
          onPressed: () async {
            final picker = ImagePicker();
            final XFile? pickedFile = await picker.pickImage(
              // source: ImageSource.gallery,
              source: ImageSource.camera,
              imageQuality: 50,
            );
            setState(() {
              _imageFile = pickedFile;
            });

            if (pickedFile == null) {
              print('No seleccionó nada');

              return;
            }
          },
        ),
      ),
    );
  }
}
