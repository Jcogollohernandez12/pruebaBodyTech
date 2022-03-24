import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/input_decorations.dart';
import '../Providers/providers.dart';
import '../Services/services.dart';

class FromLogin extends StatelessWidget {
  const FromLogin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFromProvider>(context);
    final autService = Provider.of<AuthService>(context, listen: false);
    return Form(
      key: loginForm.claveForm,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          _entradaCorreo(loginForm),
          const SizedBox(height: 30),
          _entradaPassword(loginForm),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.amber,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  autService.isLoading ? 'Espere' : 'Ingresar',
                  style: const TextStyle(color: Colors.black),
                )),
            onPressed: () async {
              if (!loginForm.isValidForm()) return;

              final String error = await autService.inicioSesion(
                  loginForm.email, loginForm.password);

              if (error.isEmpty) {
                Navigator.pushReplacementNamed(context, 'paginas');
              } else {
                _alerta(context, error);
              }
            },
          )
        ],
      ),
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
}
