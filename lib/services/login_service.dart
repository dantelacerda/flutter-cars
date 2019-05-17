import 'dart:convert';

import 'package:cars/services/login_response.dart';
import 'package:http/http.dart' as http;

class LoginService {

  static Future<LoginResponse> login(String login, String senha) async {

    var url = 'http://livrowebservices.com.br/rest/login';
    
    final response = await http.post(url, body: {"login": login, "senha": senha });
    final bodyString = response.body;

    final retorno = LoginResponse.fromJson(json.decode(bodyString));

    return retorno;
  }
}