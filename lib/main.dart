import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba2/routes/routes.dart';

import 'Screens/screens.dart';
import 'Services/services.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => UsuariosService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BodyTech',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: obtenerRutas(),
      //si la ruta no esta definida se dispara el metodo onGenerateRoute
      onGenerateRoute: (RouteSettings settings) {
        //print('ruta llamada: ${settings.name}'); //imprime el nombre de la ruta
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginApp());
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
