import 'package:cars/model/carro.dart';
import 'package:cars/pages/carro_page.dart';
import 'package:share/share.dart';
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
              onLongPress: () {
                _onLongClickCarro(context, c);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                          child: Image.network(c.urlFoto ??
                              "http://1.bp.blogspot.com/-t6_zmIRBeL8/UjXbvBlt5bI/AAAAAAAAG8Y/6o3urfkPCFQ/s1600/irmaos+rocha.png",
                          height: 150,)),

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
                              child: const Text('SHARE'),
                              onPressed: () {
                                _onClickShare(context, c);
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

  void _onLongClickCarro(BuildContext context, Carro c) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  c.nome,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Icon(Icons.directions_car),
                title: Text("Detalhes"),
                onTap: () {
                  pop(context);
                  _onClickCarro(context, c);
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share"),
                onTap: () {
                  pop(context);
                  _onClickShare(context, c);
                },
              ),
            ],
          );
        });
  }

  void _onClickShare(BuildContext context, Carro c) {
    print("Share ${c.nome}");

    Share.share(c.urlFoto);
  }
}
