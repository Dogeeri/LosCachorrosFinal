import 'package:flutter/material.dart';
import 'package:trabajo/providers/Noticias_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NoticiasUnlogPage extends StatefulWidget {
  NoticiasUnlogPage({Key? key}) : super(key: key);

  @override
  State<NoticiasUnlogPage> createState() => _NoticiasUnlogPageState();
}

class _NoticiasUnlogPageState extends State<NoticiasUnlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de noticias sin login requerido'),
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
                                  'https://thumbs.dreamstime.com/b/post-note-17342268.jpg')),
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
                      );
                    },
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
