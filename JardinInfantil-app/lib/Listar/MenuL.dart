import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trabajo/Listar/ListadoCursos/ListCursos.dart';
import 'package:trabajo/Listar/ListadoEventos/ListEventos.dart';
import 'package:trabajo/providers/Curso_provider.dart';

class MenuL extends StatefulWidget {
  MenuL({Key? key}) : super(key: key);

  @override
  State<MenuL> createState() => _MenuLState();
}

class _MenuLState extends State<MenuL> {
  final double iconHeight = 144;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: Icon(MdiIcons.clipboardList),
        title: Text('Listados'),
        backgroundColor: Color.fromARGB(255, 255, 132, 24),
      ),
      body: Column(
        
        children: [

          Expanded(
            
            child: ListView(
              
              children: [
                Divider(),
                curso(),
                Divider(),
                eventos()
                /*profesores(),
                Divider(),
                kids()*/
              ],
            ))
        ],
      ),
    );
  }



  ListTile curso (){
    return ListTile(
      onTap: () {
      MaterialPageRoute route = MaterialPageRoute(builder: (context) {
        return ListCursos();
      });
      Navigator.push(context, route);
      },
      leading:CircleAvatar(
        child: Image.network('https://www.netacad.com/sites/default/files/images/educator/icon-download-250.png'),
        radius: iconHeight / 4,
      ),
      title: Text('Listado de cursos', style: TextStyle(fontSize: 20),),
    );
  
  }


  ListTile eventos (){
    return ListTile(
      onTap: () {
      MaterialPageRoute route = MaterialPageRoute(builder: (context) {
        return EventosPage();
      });
      Navigator.push(context, route);
      },
      leading:CircleAvatar(
        child: Image.network('https://www.netacad.com/sites/default/files/images/educator/icon-download-250.png'),
        radius: iconHeight / 4,
      ),
      title: Text('Listado de Eventos', style: TextStyle(fontSize: 20),),
    );

  }
  /*
  ListTile kids (){
    return ListTile(
      onTap: () {
      MaterialPageRoute route = MaterialPageRoute(builder: (context) {
        return Kids();
      });
      Navigator.push(context, route);
      },
      leading:CircleAvatar(
        child: Image.network('https://png.pngtree.com/png-vector/20190712/ourlarge/pngtree-user-management-icon-trendy-style-isolated-background-png-image_1542354.jpg'),
        radius: iconHeight / 4,
      ),
      title: Text('Niños', style: TextStyle(fontSize: 20),),
    );
  }*/
}