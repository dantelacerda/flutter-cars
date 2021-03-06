import 'package:cars/model/carro.dart';
import 'package:cars/pages/carro-form-page.dart';
import 'package:cars/utils/nav.dart';
import 'package:cars/utils/prefs.dart';
import 'package:cars/widgets/carros_page.dart';
import 'package:cars/widgets/favoritos_page.dart';
import 'package:flutter/material.dart';

import '../drawer_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController tabController;

  @override
  initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);

    Prefs.getInt("tabIndex").then((idx) {
      tabController.index = idx;
    });


    tabController.addListener(() async {
      int idx = tabController.index;

      Prefs.setInt("tabIndex", idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: TabBar(controller: tabController, tabs: [
          Tab(text: "Clássicos", icon: Icon(Icons.directions_car)),
          Tab(text: "Esportivos", icon: Icon(Icons.directions_car)),
          Tab(text: "Luxo", icon: Icon(Icons.directions_car)),
          Tab(text: "Favoritos", icon: Icon(Icons.favorite)),
        ]),
      ),
      body: TabBarView(controller: tabController, children: [
        CarrosPage(TipoCarro.classicos),
        CarrosPage(TipoCarro.esportivos),
        CarrosPage(TipoCarro.luxo),
        FavoritosPage(),
      ]),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            push(context, CarroFormPage());
          }),
      drawer: DrawerList(),
    );
  }
}
