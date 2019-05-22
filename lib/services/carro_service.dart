import 'dart:io';

import 'package:cars/model/carro.dart';
import 'package:cars/services/response.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class CarroService {
  static Future<List<Carro>> getCarros(String tipo) async {

    final url = "http://livrowebservices.com.br/rest/carros/tipo/$tipo";
    print("> get: $url");

    final response = await http.get(url);

//    print("< : ${response.body}");

    final mapCarros = json.decode(response.body).cast<Map<String, dynamic>>();
    final carros = mapCarros.map<Carro>((json) => Carro.fromJson(json)).toList();

    return carros;
  }

  static Future<Response> salvar(Carro c, File fotoCarro) async {

    if(fotoCarro != null) {
      final fotoResponse = await upload(fotoCarro);
      c.urlFoto = fotoResponse.url;
    }

    final url = "http://livrowebservices.com.br/rest/carros";
    final headers = {"Content-Type":"application/json"};
    final body = json.encode(c.toMap());

    final response = await http.post(url, headers: headers, body: body);

    final bodyString = response.body;

    final retorno = Response.fromJson(json.decode(bodyString));

    return retorno;
  }

  static Future<Response> deletar(id) async {

    final url = "http://livrowebservices.com.br/rest/carros/$id";

    final response = await http.delete(url);

    final bodyString = response.body;

    final retorno = Response.fromJson(json.decode(bodyString));

    return retorno;
  }

  static Future<Response> upload(File file) async {
    final url = "http://livrowebservices.com.br/rest/carros/postFotoBase64";

    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    String fileName = path.basename(file.path);

    var body = {"fileName": fileName, "base64": base64Image};
    print("http.upload >> " + body.toString());

    final response = await http.post(url, body: body);

    print("http.upload << " + response.body);

    Map<String, dynamic> map = json.decode(response.body);

    var r = Response.fromJson(map);

    return r;
  }

  static Future<String> getLoremIpsum() async {
    final url = "https://loripsum.net/api";

    final response = await http.get(url);

    var body = response.body;
    body = body.replaceAll("<p>", "");
    body = body.replaceAll("</p>", "");
    return body;
  }




}