import 'dart:convert';
import 'dart:io';
import 'package:cars/utils/util.dart';
import 'package:connectivity/connectivity.dart';
import 'package:cars/services/response.dart';
import 'package:http/http.dart' as http;

class LoginService {

  static Future<Response> login(String login, String senha) async {

    //Verificando o tipo da conexão
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return Response("No Internet", "Internet Indisponível");
    } else if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
    }

    try {
      var url = 'http://livrowebservices.com.br/rest/login';

      final response = await http.post(url, body: {"login": login, "senha": senha });
      final bodyString = response.body;

      final retorno = Response.fromJson(json.decode(bodyString));

      return retorno;
    } catch(error) {
      return Response("Error", handleErrorLogin(error));
    }
  }


}