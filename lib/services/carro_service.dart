import 'package:cars/model/carro.dart';
import 'package:cars/services/response.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  static Future<Response> salvar(Carro c) async {

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

  static Future<String> getLoremIpsum() async {
    final url = "https://loripsum.net/api";

    final response = await http.get(url);

    var body = response.body;
    body = body.replaceAll("<p>", "");
    body = body.replaceAll("</p>", "");
    return body;
  }




}