import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabajo/Gestion/Curso/Curso_agregar_page.dart';
import 'package:trabajo/Gestion/Curso/Curso_editar.dart';
import 'package:trabajo/providers/Curso_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CursoPage extends StatefulWidget {
  CursoPage({Key? key}) : super(key: key);

  @override
  State<CursoPage> createState() => _CursoPageState();
}

class _CursoPageState extends State<CursoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de cursos'),
        backgroundColor: Color.fromARGB(255, 104, 156, 0),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: CursoProvider().getCurso(),
                builder: (context, AsyncSnapshot snap){
                  if(!snap.hasData){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (_,__) => Divider(),
                    itemCount: snap.data.length,
                    itemBuilder: (context, index){
                      var cur = snap.data[index];
                      return Slidable(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Image.network('https://cdn.icon-icons.com/icons2/1459/PNG/512/2799204-management_99783.png')
                          ),
                          title: Container(
                            child:Row(children: [
                              Text('${cur['curso']}', style: TextStyle(fontSize: 18, color: Colors.indigo),),
                              Spacer(),
                              Text('Nivel: ${cur['cod_curso']}', style: TextStyle(fontSize: 18, color: Colors.indigo),)  
                            ],) 
                            ),
                          subtitle: Text('Cantidad de alumnos:${cur['cantidad']}'),
                        ),
                        startActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => CursoEditarPage(cur['cod_curso']),
                                );
                                Navigator.push(context, route).then((value) {
                                  setState(() {});
                                });
                              },
                              backgroundColor: Colors.purple,
                              label: 'Editar',
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                String cod_curso = cur['cod_curso'];
                                String curso = cur['curso'];

                                confirmDialog(context, curso).then((confirma) {
                                  if (confirma) {
                                    //borrar
                                    CursoProvider().cursoBorrar(cod_curso).then((borradoOk) {
                                      if (borradoOk) {
                                        //pudo borrar
                                        snap.data.removeAt(index);
                                        setState(() {});
                                        showSnackbar('Curso $curso borrado');
                                      } else {
                                        //no pudo borrar
                                        showSnackbar('No se pudo borrar el curso');
                                      }
                                    });
                                  }
                                });
                              },
                              backgroundColor: Colors.red,
                              label: 'Borrar',
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(child: Text('Agregar', style: TextStyle(fontSize: 20),),
              onPressed: (){
                MaterialPageRoute go = MaterialPageRoute(
                  builder: (context){
                    return CursoAgregarPage();
                  });
                  Navigator.push(context, go).then((value){
                    print('Actualizar Pagina');
                    setState(() {});
                  });
              },
              style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 71, 106, 0),
                  ) ,
              ),
            )
          ],
        ),
      ),
    );
  }

  void showSnackbar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(mensaje),
      ),
    );
  }


  Future<dynamic> confirmDialog(BuildContext context, String producto) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar borrado'),
          content: Text('¿Borrar el curso $producto?'),
          actions: [
            TextButton(
              child: Text('CANCELAR'),
              onPressed: () => Navigator.pop(context, false),
            ),
            ElevatedButton(
              child: Text('ACEPTAR'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }
}