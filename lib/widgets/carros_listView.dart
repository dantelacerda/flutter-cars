import 'package:cars/model/carro.dart';
import 'package:cars/services/carro_service.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatelessWidget {

  final String tipo;
  const CarrosListView(this.tipo);

  @override
  Widget build(BuildContext context) {
    return _body(context,);
  }

  _body(BuildContext context) {

    Future futureListCar = CarroService.getCarros(tipo);

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
                return _listView(context, snapshot.data);
              }
            },
            future: futureListCar));
  }

  _listView(BuildContext context, List<Carro> carros) {
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),

                    Text(
                      c.desc,
                      style: TextStyle(color: Colors.grey, fontSize: 15),
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
}
