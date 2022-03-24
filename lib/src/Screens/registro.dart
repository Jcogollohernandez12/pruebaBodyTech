import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba2/src/Widgets/widget.dart';

import '../../ui/input_decorations.dart';
import '../Providers/login_from_provider.dart';
import '../Services/services.dart';

class RegistrarScreen extends StatelessWidget {
  const RegistrarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroudLogin(
            child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 220),
          CardContainer(
              child: Column(
            children: [
              const SizedBox(height: 10),
              Text('Crear cuenta',
                  style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 30),
              ChangeNotifierProvider(
                  create: (_) => LoginFromProvider(), child: _LoginForm()),
            ],
          )),
          const SizedBox(height: 50),
          TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              child: const Text(
                'Ya tengo una cuenta',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 181, 134, 63).withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder()))),
          const SizedBox(height: 50),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFromProvider>(context);
    final autService = Provider.of<AuthService>(context, listen: false);
    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: loginForm.claveForm,
        child: Column(
          children: [
            _entradaCorreo(loginForm),
            const SizedBox(height: 30),
            _entradaPassword(loginForm),
            const SizedBox(height: 30),
            _entradaPassword2(loginForm),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: const Color.fromARGB(255, 247, 161, 3),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    loginForm.isLoading ? 'Espere' : 'Ingresar',
                    style: const TextStyle(color: Colors.black),
                  )),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      //Pasar a la pantalla

                      if (!loginForm.isValidForm()) return;
                      loginForm.isLoading = true;
                      final String error = await autService.crearUser(
                          loginForm.email, loginForm.password);

                      await Future.delayed(const Duration(seconds: 2));

                      // TODO: validar si el login es correcto
                      loginForm.isLoading = false;

                      if (error.isEmpty) {
                        _alerta(context, 'Creacion exitosa');
                        Navigator.pushReplacementNamed(context, 'paginas');
                      } else {
                        _alerta(context, error);
                      }
                    },
            )
          ],
        ));
  }

//metodo que me permite capturar la entrada de contraseña
  Widget _entradaPassword(LoginFromProvider loginForm) {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecorations.authInputDecoration(
        hintText: '******',
        labelText: 'Contraseña',
        prefixIcon: Icons.lock_outline,
      ),
      onChanged: (value) => loginForm.password = value,
      validator: (value) {
        return (value != null && value.length >= 6)
            ? null
            : 'La contraseña debe de ser de 6 caracteres';
      },
    );
  }

  //metodo que me permite capturar la entrada de contraseña
  Widget _entradaPassword2(LoginFromProvider loginForm) {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecorations.authInputDecoration(
        hintText: '******',
        labelText: 'Repetir Contraseña',
        prefixIcon: Icons.lock_outline,
      ),
      onChanged: (value) => loginForm.password2 = value,
      validator: (value) {
        return (value == loginForm.password)
            ? null
            : 'Contraseñas no coinciden';
      },
    );
  }

//metodo que me permite capturar la entrada de Correo
  Widget _entradaCorreo(LoginFromProvider loginForm) {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecorations.authInputDecoration(
          hintText: 'josandres123@gmail.com',
          labelText: 'Correo electrónico',
          prefixIcon: Icons.alternate_email_rounded),
      onChanged: (value) => loginForm.email = value,
      validator: (value) {
        String pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = RegExp(pattern);

        return regExp.hasMatch(value ?? '')
            ? null
            : 'El valor ingresado no luce como un correo';
      },
    );
  }

  //mmetodo que me permite mostrar las alertas
  _alerta(BuildContext context, String error) async => await showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 10,
          title: const Text('Error'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    error,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Listo',
                style: TextStyle(color: Colors.indigo),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
