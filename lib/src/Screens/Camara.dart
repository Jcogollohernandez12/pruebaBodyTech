import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

import '../IA/clasificacionImg.dart';

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
  late Classifier _classifier;
  final picker = ImagePicker();
  var logger = Logger();
  img.Image? fox;
  Category? category;
  File? _image;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  @override
  void initState() {
    super.initState();
    _classifier = ClassifierQuant();
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
            height: 550,
            width: 380,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
                bottomLeft: Radius.circular(45),
                bottomRight: Radius.circular(45),
              ),
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
      child: Row(
        children: [
          Text('Es:  ${category?.label}'),
          Container(
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
                final XFile? pickedFile = await picker.pickImage(
                  // source: ImageSource.gallery,
                  source: ImageSource.camera,
                  imageQuality: 50,
                );
                setState(() {
                  _imageFile = pickedFile;
                  _image = File(pickedFile!.path);
                  // _imageWidget = Image.file(_image!);

                  _predict();
                });

                // _imageClasification(pickedFile!);

                if (pickedFile == null) {
                  print('No seleccionó nada');

                  return;
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _predict() async {
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);

    setState(() {
      category = pred;

      print(category);
    });
  }
}
