import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trabajo/providers/Curso_provider.dart';
import 'package:trabajo/providers/Noticias_provider.dart';

class NoticiaEditarPage extends StatefulWidget {
  String codNoticia;
  NoticiaEditarPage(this.codNoticia, {Key? key}) : super(key: key);

  @override
  State<NoticiaEditarPage> createState() => _NoticiaEditarPageState();
}

class _NoticiaEditarPageState extends State<NoticiaEditarPage> {
  TextEditingController codigoCtrl = TextEditingController();
  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController contenidoCtrl = TextEditingController();
  TextEditingController fechahoraCtrl = TextEditingController();
  String errCodigo = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NoticiasProvider().getNoticiaa(widget.codNoticia).then((data) {
      codigoCtrl.text = data['cod_noticia'];
      tituloCtrl.text = data['titulo'];
      contenidoCtrl.text = data['contenido'];
      fechahoraCtrl.text = data['fechahora'];
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Noticia'),
        backgroundColor: Color.fromARGB(255, 104, 156, 0),
      ),
      body: FutureBuilder(
          future: NoticiasProvider().getNoticiaa(widget.codNoticia),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            var data = snapshot.data;
            codigoCtrl.text = data['cod_noticia'].toString();
            tituloCtrl.text = data['titulo'];
            contenidoCtrl.text = data['contenido'].toString();
            fechahoraCtrl.text = data['fechahora'];

            return Form(
              key: formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: codigoCtrl,
                    decoration: InputDecoration(
                        labelText: 'Codigo', icon: Icon(MdiIcons.codeBraces)),
                    enabled: false,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      errCodigo,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextFormField(
                    controller: tituloCtrl,
                    decoration: InputDecoration(
                        labelText: 'Titulo de la noticia',
                        icon: Icon(MdiIcons.codeBraces)),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      errCodigo,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextFormField(
                    controller: contenidoCtrl,
                    decoration: InputDecoration(
                        labelText: 'Breve descripcion de la noticia',
                        icon: Icon(MdiIcons.numeric0BoxMultiple)),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      errCodigo,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Editar noticia'),
                      onPressed: () {
                        NoticiasProvider().noticiaEditar(
                            widget.codNoticia,
                            codigoCtrl.text.trim(),
                            tituloCtrl.text.trim(),
                            contenidoCtrl.text.trim(),
                            fechahoraCtrl.text.trim());
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 71, 106, 0),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
