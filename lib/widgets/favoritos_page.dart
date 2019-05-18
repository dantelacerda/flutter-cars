import 'package:cars/db/carro_db.dart';
import 'package:cars/model/carro.dart';
import 'package:cars/pages/carro_page.dart';
import 'package:cars/services/carro_service.dart';
import 'package:cars/utils/nav.dart';
import 'package:flutter/material.dart';

import 'carros_listView.dart';

class FavoritosPage extends StatefulWidget {

  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
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
    Future<List<Carro>> futureListCar = CarroDB.getInstance().getCarros();

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
