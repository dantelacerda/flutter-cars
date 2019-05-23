import 'dart:async';

import 'package:cars/model/carro.dart';
import 'package:cars/pages/carro_page.dart';
import 'package:cars/services/carro_service.dart';
import 'package:cars/services/carros_bloc.dart';
import 'package:cars/utils/nav.dart';
import 'package:cars/utils/util.dart';
import 'package:flutter/material.dart';

import 'carros_listView.dart';

class CarrosPage extends StatefulWidget {
  final String tipo;

  const CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  final _bloc = CarrosBloc();

  get tipo => widget.tipo;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Iniciando a lista de carros
    _bloc.fetchCarros(tipo);
  }

  @override
  Widget build(BuildContext context) {
    return _body(
      context,
    );
  }

  _body(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Container(
          padding: EdgeInsets.all(12),
          child: StreamBuilder(
            stream: _bloc.stream,
            builder: (context, snapshot) {
              //Caso possua algum erro, trata e escreve no meio da tela
              if (snapshot.hasError) {
                return Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Text(
                        handleErrorGeneric(snapshot.error),
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                );
                //Enquanto nao tiver carregado os dados, fica girando na tela o circulo
              } else if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
                //Quando retornar o resultado, monta a tela a partir do CarrosListView
              } else {
                final List<Carro> carros = snapshot.data;
                return CarrosListView(carros);
              }
            },
          )),
    );
  }

  // Faz funcionar o RefreshIndicator, que é o que atualiza a pagina quando puxar pra baixo
  Future<void> _onRefresh() {
    return _bloc.fetchCarros(tipo);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //Fechando a Stream aberta
    _bloc.close();
  }
}
