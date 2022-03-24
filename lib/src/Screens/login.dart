import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/providers.dart';
import '../Widgets/widget.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroudLogin(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 260),
              CardContainer(
                child: Column(
                  children: [
                    const Icon(
                      Icons.person_pin,
                      color: Color.fromARGB(255, 247, 149, 2),
                      size: 100,
                    ),
                    const SizedBox(height: 10),
                    Text('Usuario',
                        style: Theme.of(context).textTheme.headline4),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                        create: (_) => LoginFromProvider(),
                        child: const FromLogin()),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'registrar'),
                  child: const Text(
                    'Crear una nueva cuenta',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 153, 0),
                      fontSize: 15,
                    ),
                  ),
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.indigo.withOpacity(0.1)),
                      shape: MaterialStateProperty.all(const StadiumBorder()))),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
