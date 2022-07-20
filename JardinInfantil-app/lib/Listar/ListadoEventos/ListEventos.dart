import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trabajo/Gestion/Eventos/Eventos_agregar_page.dart';
import 'package:trabajo/Listar/ListadoEventos/infoEvento.dart';
//import 'package:trabajo/Listar/ListadoEventos/infoEvento.dart';
import 'package:trabajo/providers/Eventos_provider.dart';

class EventosPage extends StatefulWidget {
  EventosPage({Key? key}) : super(key: key);

  @override
  State<EventosPage> createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de eventos'),
        backgroundColor: Colors.purple,
        
      ),
      body: Column(
        children: [
          
          Expanded(
            child: FutureBuilder(
                future: EventosProvider().getEventos(),
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
                      var eve = snap.data[index];
                        return ListTile(
                          title: Row(
                            
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              
                              Divider(color: Colors.black,),
                              Icon(MdiIcons.bookAlert),
                              Text('${eve['nom_alumno']}')
                            ],
                          ),
                          subtitle:Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(255, 204, 204, 204) ,
                                        blurRadius: 3.0,
                                        offset: Offset(2.0,2.0)
                                      )
                                    ],
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 98, 115, 214),
                                        Color.fromARGB(255, 162, 196, 255)
                                      ]
                                    ),
                                    
                            ),
                            child: Column(
                              
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                
                                Container(
                                  child:Text('Asunto: ' '${eve['asunto']}',style: TextStyle(fontSize: 18, color: Colors.black,),) ,
                                ),
                                Divider(color: Colors.black,),
                                Container(
                                  child:Text('Descripción:',style: TextStyle(fontSize: 18, color: Colors.black),),
                                ),
                                Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 0.5,
                                    ),
                                    
                                  ),
                                  width: double.infinity,
                                  child: Container(
                                    
                                    color: Color(0xffE7E7E7),
                                    child:Column(
                                      children: [
                                      
                                        Text('${eve['descripcion']}',style: TextStyle(fontSize: 18, color: Colors.black),),
                                      ],
                                    ),
                                    
                                  ),
                                  
                                ),
                                
                              ],
                            ),
                          ),
                          
                        );
                    },
                  );
                },
              ),
          ),
        ],
      ),
      
    );
  }
}