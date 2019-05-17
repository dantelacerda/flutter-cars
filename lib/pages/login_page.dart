import 'package:cars/services/login_service.dart';
import 'package:cars/utils/alerts.dart';
import 'package:cars/utils/nav.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final loginField = TextEditingController(text: 'Dante');
  final senhaField = TextEditingController(text: '1234');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _progress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _body(context),
      ),
    );
  }

  String _validateLogin(String login) {
    if (login.isEmpty) {
      return "Informe o login";
    }
  }

  String _validateSenha(String senha) {
    if (senha.isEmpty) {
      return "Informe a senha";
    } else if (senha.length <= 2) {
      return "Senha precisa ter mais de 2 caracteres";
    }
  }

  _body(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: loginField,
              validator: _validateLogin,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "Login",
                  labelStyle: (TextStyle(color: Colors.black, fontSize: 25)),
                  hintText: "Digite o seu login",
                  hintStyle: TextStyle(color: Colors.black, fontSize: 10)),
            ),
            TextFormField(
                obscureText: true,
                validator: _validateSenha,
                controller: senhaField,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Senha",
                    labelStyle: (TextStyle(color: Colors.black, fontSize: 25)),
                    hintText: "Digite a sua senha",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 10))),
            Container(
                margin: EdgeInsets.only(top: 20),
                height: 50,
                child: RaisedButton(
                    child: _progress
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : Text(
                            "Login",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                    color: Colors.blue,
                    onPressed: () {
                      _onClickLogin(context);
                    }))
          ],
        ));
  }

  _onClickLogin(BuildContext context) async {
    final login = loginField.text;
    final senha = senhaField.text;

    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _progress = true;
    });

    final response = await LoginService.login(login, senha);

    if (response.isOk()) {
        pushReplacement(context, HomePage());
    } else {
      alert(context, "Error", response.msg);
    }

    setState(() {
      _progress = false;
    });
  }
}
