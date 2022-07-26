import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trabajo/Gestion/Curso/Curso_page.dart';
import 'package:trabajo/Gestion/Eventos/Eventos_page.dart';
import 'package:trabajo/Gestion/Ni%C3%B1o/Alumnos_page.dart';
import 'package:trabajo/Gestion/Noticias/Noticias_page.dart';
import 'package:trabajo/Gestion/Noticias/Noticias_unlog.dart';
import 'package:trabajo/Gestion/Profesores/Profesores.dart';

class MenuG extends StatefulWidget {
  MenuG({Key? key}) : super(key: key);

  @override
  State<MenuG> createState() => _MenuGState();
}

class _MenuGState extends State<MenuG> {
  final double iconHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(MdiIcons.bookEducation),
        title: Text('Menu de gestión'),
        backgroundColor: Color.fromARGB(255, 255, 132, 24),
      ),
      body: Column(
        children: [
          /*Container(
            height: 40,
            width: double.infinity,
            color: Colors.indigo,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Pinches Juegos',style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),)
              ]),
          ),*/
          Expanded(
              child: ListView(
            children: [
              curso(),
              Divider(),
              profesores(),
              Divider(),
              kids(),
              Divider(),
              evento(),
              Divider(),
              noticia(),
            ],
          ))
        ],
      ),
    );
  }

  ListTile curso() {
    return ListTile(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(builder: (context) {
          return CursoPage();
        });
        Navigator.push(context, route);
      },
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.network(
            'https://thumbs.dreamstime.com/b/icono-de-gesti%C3%B3n-proyectos-engranajes-lista-comprobaci%C3%B3n-administraci%C3%B3n-la-del-portapapeles-aislado-en-fondo-blanco-servicios-222483353.jpg'),
        radius: iconHeight / 4,
      ),
      title: Text(
        'Curso',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  ListTile profesores() {
    return ListTile(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(builder: (context) {
          return Profesores();
        });
        Navigator.push(context, route);
      },
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.network(
            'https://thumbs.dreamstime.com/b/icono-de-gesti%C3%B3n-proyectos-engranajes-lista-comprobaci%C3%B3n-administraci%C3%B3n-la-del-portapapeles-aislado-en-fondo-blanco-servicios-222483353.jpg'),
        radius: iconHeight / 4,
      ),
      title: Text(
        'Profesores',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  ListTile kids() {
    return ListTile(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(builder: (context) {
          return Ninos_page();
        });
        Navigator.push(context, route);
      },
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.network(
            'https://thumbs.dreamstime.com/b/icono-de-gesti%C3%B3n-proyectos-engranajes-lista-comprobaci%C3%B3n-administraci%C3%B3n-la-del-portapapeles-aislado-en-fondo-blanco-servicios-222483353.jpg'),
        radius: iconHeight / 4,
      ),
      title: Text(
        'Niños',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  ListTile evento() {
    return ListTile(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(builder: (context) {
          return EventosGest();
        });
        Navigator.push(context, route);
      },
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.network(
            'https://thumbs.dreamstime.com/b/icono-de-gesti%C3%B3n-proyectos-engranajes-lista-comprobaci%C3%B3n-administraci%C3%B3n-la-del-portapapeles-aislado-en-fondo-blanco-servicios-222483353.jpg'),
        radius: iconHeight / 4,
      ),
      title: Text(
        'Eventos',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  ListTile noticia() {
    return ListTile(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(builder: (context) {
          return NoticiasPage();
        });
        Navigator.push(context, route);
      },
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.network(
            'https://thumbs.dreamstime.com/b/icono-de-gesti%C3%B3n-proyectos-engranajes-lista-comprobaci%C3%B3n-administraci%C3%B3n-la-del-portapapeles-aislado-en-fondo-blanco-servicios-222483353.jpg'),
        radius: iconHeight / 4,
      ),
      title: Text(
        'Noticias',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
