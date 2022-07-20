import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabajo/Gestion/Curso/Curso_agregar_page.dart';
import 'package:trabajo/Gestion/Curso/Curso_editar.dart';
import 'package:trabajo/Gestion/Noticias/Noticia_agregar_page.dart';
import 'package:trabajo/Gestion/Noticias/Noticia_editar.dart';
import 'package:trabajo/providers/Noticias_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NoticiasPage extends StatefulWidget {
  NoticiasPage({Key? key}) : super(key: key);

  @override
  State<NoticiasPage> createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de noticias'),
        backgroundColor: Color.fromARGB(255, 176, 145, 7),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: NoticiasProvider().getNoticias(),
                builder: (context, AsyncSnapshot snap) {
                  if (!snap.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      var cur = snap.data[index];
                      return Slidable(
                        child: ListTile(
                          leading: CircleAvatar(
                              child: Image.network(
                                  'https://thumbs.dreamstime.com/b/generic-warning-20896820.jpg')),
                          title: Container(
                              child: Row(
                            children: [
                              Text(
                                '${cur['titulo']}',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.indigo),
                              ),
                              Spacer(),
                              Text(
                                '${cur['fechahora']}',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.indigo),
                              )
                            ],
                          )),
                          subtitle: Text('${cur['contenido']}'),
                        ),
                        startActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => NoticiaEditarPage(
                                      cur['cod_noticia'].toString()),
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
                                int cod_noticia = cur['cod_noticia'];
                                String titulo = cur['titulo'];

                                confirmDialog(context, titulo).then((confirma) {
                                  if (confirma) {
                                    //borrar
                                    NoticiasProvider()
                                        .noticiaBorrar(cod_noticia)
                                        .then((borradoOk) {
                                      if (borradoOk) {
                                        //pudo borrar
                                        snap.data.removeAt(index);
                                        setState(() {});
                                        showSnackbar('Noticia $titulo borrada');
                                      } else {
                                        //no pudo borrar
                                        showSnackbar(
                                            'No se pudo borrar la noticia');
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
              child: ElevatedButton(
                child: Text(
                  'Agregar',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  MaterialPageRoute go = MaterialPageRoute(builder: (context) {
                    return NoticiasAgregarPage();
                  });
                  Navigator.push(context, go).then((value) {
                    print('Actualizar Pagina');
                    setState(() {});
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 71, 106, 0),
                ),
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

  Future<dynamic> confirmDialog(BuildContext context, String titulo) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar borrado'),
          content: Text('¿Borrar la noticia $titulo?'),
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
