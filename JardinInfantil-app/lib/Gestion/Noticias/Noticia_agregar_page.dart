import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trabajo/providers/Noticias_provider.dart';
import 'package:trabajo/providers/Curso_provider.dart';

class NoticiasAgregarPage extends StatefulWidget {
  NoticiasAgregarPage({Key? key}) : super(key: key);

  @override
  State<NoticiasAgregarPage> createState() => _NoticiasAgregarPageState();
}

class _NoticiasAgregarPageState extends State<NoticiasAgregarPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController codigoCtrl = TextEditingController();
  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController contenidoCtrl = TextEditingController();
  TextEditingController fechahoraCtrl = TextEditingController();

  String errCodigo = '';
  String errCurso = '';
  String errCant = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticia'),
        backgroundColor: Color.fromARGB(255, 104, 156, 0),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextFormField(
                controller: codigoCtrl,
                decoration: InputDecoration(
                    labelText: 'Codigo', icon: Icon(MdiIcons.codeBraces)),
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
                  errCurso,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                controller: contenidoCtrl,
                decoration: InputDecoration(
                    labelText: 'Breve resumen de la noticia',
                    icon: Icon(MdiIcons.numeric0BoxMultiple)),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errCant,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                controller: fechahoraCtrl,
                decoration: InputDecoration(
                    labelText: 'Fecha y hora de la noticia',
                    icon: Icon(MdiIcons.numeric0BoxMultiple)),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errCant,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Agregar Noticia'),
                  onPressed: () async {
                    var respuesta = await NoticiasProvider().noticiaAgregar(
                      codigoCtrl.text.trim(),
                      tituloCtrl.text.trim(),
                      contenidoCtrl.text.trim(),
                      fechahoraCtrl.text.trim(),
                    );

                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 71, 106, 0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
