import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trabajo/Gestion/Eventos/Eventos_agregar_page.dart';
import 'package:trabajo/Gestion/Eventos/Eventos_editar.dart';
import 'package:trabajo/Gestion/Ni%C3%B1o/Alumnos_agregar_page.dart';
import 'package:trabajo/providers/Alumnos_provider.dart';
import 'package:trabajo/Gestion/Niño/Alumnos_editar_page.dart';
import 'package:trabajo/providers/Eventos_provider.dart';

class EventosGest extends StatefulWidget {
  EventosGest({Key? key}) : super(key: key);

  @override
  State<EventosGest> createState() => _EventosGestState();
}

class _EventosGestState extends State<EventosGest> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos Gestion'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: EventosProvider().getEventos(),
                builder: (context,AsyncSnapshot snap){
                  if(!snap.hasData){
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.separated(
                    separatorBuilder:(_,__)=> Divider(),
                    itemCount:snap.data.length,
                    itemBuilder:(context,index){
                      var eve = snap.data[index];
                      return Slidable(
                        child: ListTile(
                          leading: Icon(MdiIcons.exclamationThick),
                          title:  Text('[${eve['cod_evento']}] ${eve['nom_alumno']}'),
                          subtitle: Text('Asunto: ''${eve['asunto']}'),
                        ),
                        startActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context){
                                MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => Eventos_editar_page(eve['cod_evento']),
                                );
                                Navigator.push(context, route).then((value){
                                  setState(() { });
                                },);
                                
                              },
                              backgroundColor: Colors.purple,
                              icon: MdiIcons.pen,
                              label: 'Editar',
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context){
                                int cod_evento = eve['cod_evento'];
                                String nom_alumno = eve['nom_alumno'];

                                confirmDialog(context, cod_evento.toString()).then((confirma){
                                  if(confirma){
                                    EventosProvider().eventoBorrar(cod_evento).then((borradoOK){
                                      if (borradoOK){
                                        snap.data.removeAt(index);
                                        setState(() {});
                                        showSnackbar('Evento $cod_evento borrado');
                                      }else{
                                        showSnackbar('No se pudo eliminar el evento');
                                      }
                                    });
                                  }
                                });
                              },
                              backgroundColor: Colors.red,
                              icon: MdiIcons.trashCan,
                              label: 'Borrar',
                            )
                          ],
                        ),
                      );
                    }
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              
              child: ElevatedButton(child: Text('Agregar'),
              onPressed: (){
                MaterialPageRoute go = MaterialPageRoute(
                  builder: (context){
                    return EventosAgregar();
                  });
                  Navigator.push(context, go).then((value){
                    print('Actualizar Pagina');
                    setState(() {});
                  });
              },
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 113, 7, 132),
              )
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
  Future<dynamic>confirmDialog(BuildContext context, String alumno){
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Confirmar borrado'),
          content: Text('¿Borrar el evento de $alumno?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.pop(context, false),
            ),
            ElevatedButton(
              child: Text('Aceptar'),
              onPressed: () => Navigator.pop(context, true),
            )
          ],
        );
      }
    );
  }
}