import 'dart:io';

import 'package:flutter/material.dart';

calculateHeight(BuildContext context, double heigth) {
  return MediaQuery.of(context).size.height * heigth;
}

calculateWidth(BuildContext context, double width) {
  return MediaQuery.of(context).size.width * width;
}

handleErrorLogin(error) {
  String retorno;
  if (error is SocketException) {
    retorno = "Internet indisponível. Por favor, verifique a sua conexão";
  } else {
    retorno = "Ocorreu um erro no login";
  }
  return retorno;
}

handleErrorGeneric(error) {
  String retorno;
  if (error is SocketException) {
    retorno = "Internet indisponível. Por favor, verifique a sua conexão";
  } else {
    retorno = "Ocorreu um erro para buscar os dados";
  }
  return retorno;
}
