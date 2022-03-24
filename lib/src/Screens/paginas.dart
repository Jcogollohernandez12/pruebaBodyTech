import 'package:flutter/material.dart';
import 'package:prueba2/src/Screens/screens.dart';

class PaginasOpcion extends StatefulWidget {
  const PaginasOpcion({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PaginasOpcionState();
}

class _PaginasOpcionState extends State<PaginasOpcion> {
  int _indexPagina = 0;

  @override
  Widget build(BuildContext context) {
    //conteido de as paginas

    final _contenidoPaginas = <Widget>[
      const Center(
        child: CamaraScreen(),
      ),
      const Center(
        child: ListaUsuariosScreen(),
      ),
    ];

    //boton de itemnes de la paginas
    final _botonItemNav = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.camera_alt,
        ),
        label: 'Camara',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.list_alt),
        label: 'Lista',
      ),
    ];

    assert(_contenidoPaginas.length == _botonItemNav.length);

    //navegacion hacia la pantalla indicada
    final bottomNavBar = BottomNavigationBar(
      items: _botonItemNav,
      currentIndex: _indexPagina,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _indexPagina = index;
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BodyTech Prueba',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 252, 123, 3),
      ),
      body: _contenidoPaginas[_indexPagina],
      bottomNavigationBar: bottomNavBar,
    );
  }
}
