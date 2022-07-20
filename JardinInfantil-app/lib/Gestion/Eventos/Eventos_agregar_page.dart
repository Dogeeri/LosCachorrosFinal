import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trabajo/providers/Alumnos_provider.dart';
import 'package:trabajo/providers/Curso_provider.dart';
import 'package:trabajo/providers/Eventos_provider.dart';

class EventosAgregar extends StatefulWidget {
  EventosAgregar({Key? key}) : super(key: key);

  @override
  State<EventosAgregar> createState() => _EventosAgregarState();
}

class _EventosAgregarState extends State<EventosAgregar> {
  final formKey = GlobalKey<FormState>();

  TextEditingController ninoCtrl = TextEditingController();
  TextEditingController asuntoCtrl = TextEditingController();
  TextEditingController descripcionCtrl = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();
  String alum = '';

  String errAlumno = "";
  String errAsunto = "";
  String errDescripcion = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Evento'),
        backgroundColor: Colors.purple,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                      value: alum.isEmpty ? null : alum,
                      onChanged: (nuevo) {
                        setState(() {
                          alum = nuevo.toString();
                        });
                      },
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errAlumno,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Divider(),
              TextFormField(
                controller: asuntoCtrl,
                decoration: InputDecoration(icon: Icon(MdiIcons.pencilPlusOutline), labelText: 'Asunto'),
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
              
              
              Container(
                width: double.infinity,
                child: Text(
                  errDescripcion,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Divider(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Agregar Evento'),
                  onPressed: ()async{
                    //int edad = int.tryParse(edadCtrl.text)??0;

                    var respuesta = await EventosProvider().eventoAgregar(alum.toString(), asuntoCtrl.text.trim(), descripcionCtrl.text.trim());
                    
                    if (respuesta['message']!= null){
                      //codigo
                      if(respuesta['errors']['nom_alumno']!=null){
                        errAlumno = respuesta['errors']['nom_alumno'][0];
                      }else{
                        errAlumno = '';
                      }

                      //nombre
                       if(respuesta['errors']['asunto']!=null){
                        errAsunto = respuesta['errors']['asunto'][0];
                      }else{
                        errAsunto = '';
                      }

                      //
                       if(respuesta['errors']['descripcion']!=null){
                        errDescripcion = respuesta['errors']['descripcion'][0];
                      }else{
                        errDescripcion = '';
                      }

                      setState(() {
                        
                      });
                      return;
                    }Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 113, 7, 132),
                  )
                ),
              )

              
            ],
          ),
          
        ),
        
      ),
      
    );
  }
}