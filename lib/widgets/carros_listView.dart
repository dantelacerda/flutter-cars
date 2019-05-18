import 'package:cars/model/carro.dart';
import 'package:cars/pages/carro_page.dart';
import 'package:cars/services/carro_service.dart';
import 'package:cars/utils/nav.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatelessWidget {

  final List<Carro> carros;

  const CarrosListView(this.carros);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: carros.length,
        itemBuilder: (ctx, idx) {
          final c = carros[idx];
          return Container(
//            height: calculateHeight(context, 0.4),
            child: InkWell(
              onTap: () {
                _onClickCarro(context, c);
              },
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
                              child: const Text('DETALHES'),
                              onPressed: () {
                                _onClickCarro(context, c);
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
            ),
          );
        });
  }

  void _onClickCarro(BuildContext context, Carro c) {
    push(context, CarroPage(c));
  }
}
