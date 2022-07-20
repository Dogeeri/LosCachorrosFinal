import 'package:flutter/material.dart';
import 'package:trabajo/providers/educadoras_provider.dart';
import 'package:trabajo/providers/Alumnos_provider.dart';

class infcurso extends StatefulWidget {
  String cursoSelected = "";
  infcurso(this.cursoSelected, {Key? key}) : super(key: key);

  @override
  State<infcurso> createState() => _infcursoState();
}

class _infcursoState extends State<infcurso> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informacion del curso ${widget.cursoSelected}'),
        backgroundColor: Color.fromARGB(255, 21, 151, 0),
      ),
      body: Padding(
        padding: EdgeInsets.all(2),
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //crossAxisAlignment: CrossAxisAlignment.center,
        //traer los profes y niños del nivel seleccionado, filtrar segun curso
        child: Column(
          children: [
            Container(
              
              child: Text('Educadoras',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  
            ),
            Container(
              height: 150,
              
              child:FutureBuilder(
                future: EducadorasProvider().getEducadorascurso(widget.cursoSelected),
                
                builder: (context, AsyncSnapshot snap) {
                  if (!snap.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  print(snap.data);
                  return ListView.separated(
                  
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      var prod = snap.data[index];
                      
                        return ListTile(
                          leading: Icon(Icons.school),
                          title: Text(prod['nombre'], style: TextStyle(fontSize: 18),),
                          subtitle: Text((prod['telefono']).toString()),
                          //trailing: Text('Edad: ' + (prod['edad']).toString(), style: TextStyle(fontSize: 15)),
                        );
                      }
                    
                  );
                },
              ) ,
            ),
            Divider(color: Colors.black,),
            
            Container(
              
              child: Text('Alumnos',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
            
              child: FutureBuilder(
                future: AlumnosProvider().getAlumnoscurso(widget.cursoSelected),
                
                builder: (context, AsyncSnapshot snap) {
                  if (!snap.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  
                  print(snap.data);
                  return ListView.separated(
                  
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      var prod = snap.data[index];
                      
                        return ListTile(
                          leading: Icon(Icons.child_care_rounded),
                          title: Text(prod['nom_alumno'], style: TextStyle(fontSize: 18),),
                          subtitle: Text(prod['direccion']),
                          trailing: Text('Edad: ' + (prod['edad']).toString(), style: TextStyle(fontSize: 15)),
                        );
                      }
                    
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
