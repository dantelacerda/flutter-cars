import 'package:cars/model/carro.dart';
import 'package:cars/services/carro_service.dart';
import 'package:cars/utils/util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: _listView(context),
      ),
    );
  }

  _listView(BuildContext context) {
    final carros = CarroService.getCarros();
    return ListView.builder(
        itemCount: carros.length,
        itemBuilder: (ctx, idx) {
          final c = carros[idx];
          return Container(
//            height: calculateHeight(context, 0.4),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(child: Image.network(c.urlFoto)),

                    Text(
                      c.nome,
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),

                    Text(
                      "Descrição",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),

                    //BOTOES EM BAIXO DOS CARROS
                    ButtonTheme.bar(
                      // make buttons use the appropriate styles for cards
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('BUY TICKETS'),
                            onPressed: () {
                              /* ... */
                            },
                          ),
                          FlatButton(
                            child: const Text('LISTEN'),
                            onPressed: () {
                              /* ... */
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  ListTile listTile(Carro c, BuildContext context) {
    return ListTile(
      //LEADING é o que vai ficar na esquerda da imagem
      leading: Image.network(
        c.urlFoto,
        width: calculateWidth(context, 0.4),
      ),

      title: Text(
        c.nome,
        style: TextStyle(color: Colors.blue, fontSize: 25),
      ),
      subtitle: Text("descrição",
          style: TextStyle(color: Colors.black, fontSize: 15)),
    );
  }
}
