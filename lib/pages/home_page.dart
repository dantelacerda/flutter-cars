import 'package:cars/model/carro.dart';
import 'package:cars/widgets/carros_listView.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Carros"),
          bottom: TabBar(tabs: [
            Tab(text: "Clássicos",icon: Icon(Icons.directions_car)),
            Tab(text: "Esportivos",icon: Icon(Icons.directions_car)),
            Tab(text: "Luxo",icon: Icon(Icons.directions_car))
          ]),
        ),
        body: TabBarView(children:
        [ CarrosListView(TipoCarro.classicos),
          CarrosListView(TipoCarro.esportivos),
          CarrosListView(TipoCarro.luxo)]),
      ),
    );
  }


}
