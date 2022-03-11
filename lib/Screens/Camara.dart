import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:prueba2/main.dart';

class CamaraScreen extends StatefulWidget {
  const CamaraScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CamaraScreen> createState() => _CamaraScreenState();
}

class _CamaraScreenState extends State<CamaraScreen> {
  CameraController? controller;
  bool _isCameraInitialized = false;

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(
      () {
        if (mounted) setState(() {});
      },
    );

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  void initState() {
    onNewCameraSelected(camaras[0]);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }

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
