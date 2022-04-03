import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba2/src/routes/routes.dart';

import 'src/Screens/screens.dart';
import 'src/Services/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => UsuariosService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BodyTech',
      debugShowCheckedModeBanner: false,
      initialRoute: 'paginas',
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
