import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trabajo/providers/Alumnos_provider.dart';
import 'package:trabajo/providers/Curso_provider.dart';
import 'package:trabajo/providers/Eventos_provider.dart';
class Eventos_editar_page extends StatefulWidget {
  int codEvento;
  Eventos_editar_page(this.codEvento,{Key? key}) : super(key: key);

  @override
  State<Eventos_editar_page> createState() => _Eventos_editar_pageState();
}

class _Eventos_editar_pageState extends State<Eventos_editar_page> {
  TextEditingController codigoCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController asuntoCtrl = TextEditingController();
  TextEditingController descripcionCtrl = TextEditingController();

  String errAsunto = "";
  String errDescripcion = '';
  
  final formKey = GlobalKey<FormState>();

  String alum = '';
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Evento'),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder(
        future: EventosProvider().getEvento(widget.codEvento),
        builder:(context, AsyncSnapshot snapshot){
          if (!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data;
          nombreCtrl.text = data['nom_alumno'];
          asuntoCtrl.text = data['asunto'];
          descripcionCtrl.text = data['descripcion'];

          return Form(
            key: formKey,
            child: ListView(
              children: [

                Container(
                child: FutureBuilder(
                  future: AlumnosProvider().getAlumnos(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      //return Text('Cargando regiones...');
                      return DropdownButtonFormField<String>(
                        hint: Text('Cargando alumnos...'),
                        items: [],
                        onChanged: (valor) {},
                      );
                    }
                    var alumnos = snapshot.data;
                    return DropdownButtonFormField<String>(       
                      hint: Text('Alumnos'),
                      items: alumnos.map<DropdownMenuItem<String>>((alum) {                        
                        return DropdownMenuItem<String>(                          
                          child: Text(alum['nom_alumno']),
                          value: alum['nom_alumno'],
                        );
                      }).toList(),
                      value: nombreCtrl.text,
                      onChanged: (nuevo) {
                        alum = nuevo.toString();
                      },
                    );
                  },
                ),
              ),

                Divider(),
              TextFormField(
                controller: asuntoCtrl,
                decoration: InputDecoration(labelText: 'Asunto', icon: Icon(MdiIcons.pencilPlusOutline),),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errAsunto,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Divider(),
              TextFormField(
                controller: descripcionCtrl,
                onFieldSubmitted: (String value){
                      setState(() {
                        descripcionCtrl.text = value;
                      });
                },
                decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: "Descripcion",
                      icon: Icon(MdiIcons.bookmark)
                ),
                maxLength: 100,
              ),
              Divider(),
              
              Container(
                width: double.infinity,
                child: Text(
                  errDescripcion,
                  style: TextStyle(color: Colors.red),
                ),
              ),
                
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Editar'),
                    onPressed: (){
                      if (alum.isEmpty){
                        alum = nombreCtrl.text;
                      }          


                      EventosProvider().eventoEditar(widget.codEvento, alum, asuntoCtrl.text.trim(), descripcionCtrl.text.trim());
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 113, 7, 132),
                    )
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}