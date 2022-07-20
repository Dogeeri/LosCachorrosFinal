import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trabajo/providers/Curso_provider.dart';

class CursoEditarPage extends StatefulWidget {
  String codCurso;
  CursoEditarPage(this.codCurso, {Key? key}) : super(key: key);

  @override
  State<CursoEditarPage> createState() => _CursoEditarPageState();
}

class _CursoEditarPageState extends State<CursoEditarPage> {
  TextEditingController codigoCtrl = TextEditingController();
  TextEditingController cursoCtrl = TextEditingController();
  TextEditingController cantidadCtrl = TextEditingController();
  String errCodigo = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    CursoProvider().getCursoo(widget.codCurso).then((data){
      codigoCtrl.text = data['cod_curso'];
      cursoCtrl.text = data['curso'];
      cantidadCtrl.text = data['cantidad'].toString();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar curso'),
        backgroundColor: Color.fromARGB(255, 104, 156, 0),
      ),
      body: FutureBuilder(
          future: CursoProvider().getCursoo(widget.codCurso),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            var data = snapshot.data;
            codigoCtrl.text = data['cod_curso'];
            cursoCtrl.text = data['curso'];
            cantidadCtrl.text = data['cantidad'].toString();

            return Form(
              key: formKey,
              child: ListView(
                children: [
                 
                  TextFormField(
                  controller: codigoCtrl,
                  decoration: InputDecoration(labelText: 'Nivel', icon: Icon(MdiIcons.codeBraces)),
                  enabled: false,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(errCodigo,style: TextStyle(color: Colors.red),),
                  ),
                  TextFormField(
                  controller: cursoCtrl,
                  decoration: InputDecoration(labelText: 'Nombre del Curso', icon: Icon(MdiIcons.codeBraces)),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(errCodigo,style: TextStyle(color: Colors.red),),
                  ),
                  TextFormField(
                  controller: cantidadCtrl,
                  decoration: InputDecoration(labelText: 'Cantidad de alumnos', icon: Icon(MdiIcons.numeric0BoxMultiple)),
                  keyboardType: TextInputType.number,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(errCodigo,style: TextStyle(color: Colors.red),),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Editar'),
                      onPressed: () {
                        CursoProvider().cursoEditar(
                          widget.codCurso,
                          codigoCtrl.text.trim(),
                          cursoCtrl.text.trim(),
                          int.tryParse(cantidadCtrl.text.trim()) ?? 0,
                        );
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 71, 106, 0),
                  ) ,
                    ),
                  ),
                  
                  
                ],
              ),
            );
          }),
    );
  }
}