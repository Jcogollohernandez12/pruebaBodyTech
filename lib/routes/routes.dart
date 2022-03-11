import 'package:flutter/material.dart';

import '../Screens/screens.dart';

Map<String, WidgetBuilder> obtenerRutas() {
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => const LoginApp(),
    'registrar': (BuildContext context) => const RegistrarScreen(),
    'paginas': (BuildContext context) => const PaginasOpcion(),
  };
}
