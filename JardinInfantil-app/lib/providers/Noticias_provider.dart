import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NoticiasProvider {
  final String apiURL = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> getNoticias() async {
    var uri = Uri.parse('$apiURL/noticias');
    var respuesta = await http.get(uri);
    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<LinkedHashMap<String, dynamic>> getNoticiaa(String codNoticia) async {
    var uri = Uri.parse('$apiURL/noticias/$codNoticia');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  Future<LinkedHashMap<String, dynamic>> noticiaEditar(
      String cod_noticia,
      String cod_noticia_nuevo,
      String titulo,
      String contenido,
      String fechahora) async {
    var uri = Uri.parse('$apiURL/noticias/$cod_noticia');
    var respuesta = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'cod_noticia': cod_noticia,
          'cod_noticia_nuevo': cod_noticia_nuevo,
          'titulo': titulo,
          'contenido': contenido,
          'fechahora': fechahora,
        }));
    return json.decode(respuesta.body);
  }

  Future<LinkedHashMap<String, dynamic>> noticiaAgregar(String cod_noticia,
      String titulo, String contenido, String fechahora) async {
    var uri = Uri.parse('$apiURL/noticias');
    var respuesta = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'cod_noticia': cod_noticia,
          'titulo': titulo,
          'contenido': contenido,
          'fechahora': fechahora
        }));
    return json.decode(respuesta.body);
  }

  Future<bool> noticiaBorrar(int cod_noticia) async {
    var uri = Uri.parse('$apiURL/noticias/$cod_noticia');
    var respuesta = await http.delete(uri);

    return respuesta.statusCode == 200;
  }
}
