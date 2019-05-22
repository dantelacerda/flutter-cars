import 'dart:convert';

import 'package:cars/services/response.dart';
import 'package:http/http.dart' as http;

class LoginService {

  static Future<Response> login(String login, String senha) async {

    var url = 'http://livrowebservices.com.br/rest/login';
    
    final response = await http.post(url, body: {"login": login, "senha": senha });
    final bodyString = response.body;

    final retorno = Response.fromJson(json.decode(bodyString));

    return retorno;
  }
}