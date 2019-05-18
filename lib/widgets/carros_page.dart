import 'package:cars/model/carro.dart';
import 'package:cars/pages/carro_page.dart';
import 'package:cars/services/carro_service.dart';
import 'package:cars/utils/nav.dart';
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
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return _body(
      context,
    );
  }

  _body(BuildContext context) {

    //Web Service
    Future<List<Carro>> futureListCar = CarroService.getCarros(widget.tipo);

    return Container(
        padding: EdgeInsets.all(12),
        child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Nenhum carro encontrado",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ));
              } else if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                final List<Carro> carros = snapshot.data;
                return CarrosListView(carros);
              }
            },
            future: futureListCar));
  }
}
