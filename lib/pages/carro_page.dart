import 'package:cars/db/carro_db.dart';
import 'package:cars/model/carro.dart';
import 'package:cars/services/carro_service.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  final Carro carro;

  const CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  get carro => widget.carro;

  bool _isFavorito = false;

  @override
  void initState() {
    super.initState();

    CarroDB.getInstance().exists(carro).then((exist) {
        setState(() {
          _isFavorito = exist;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(carro.nome)),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        Image.network(carro.urlFoto),
        _rowNameAndLike(),
        _columnCarDescription(),
      ],
    );
  }

  Row _rowNameAndLike() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                carro.nome,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                carro.tipo,
                style: TextStyle(fontSize: 15, color: Colors.grey[500]),
              )
            ],
          ),
        ),
        InkWell(
            onTap: () {
              _onClickFavorito(context, carro);
            },
            child: Icon(
              Icons.favorite,
              color: _isFavorito ? Colors.red : Colors.grey,
              size: 36,
            )),
        InkWell(
            onTap: () {},
            child: Icon(
              Icons.share,
              size: 36,
            )),
      ],
    );
  }

  _columnCarDescription() {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            carro.desc,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder<String>(
            future: CarroService.getLoremIpsum(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Text(snapshot.data)
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  void _onClickFavorito(BuildContext context, carro) async {

    final db = CarroDB.getInstance();

    final carExist = await db.exists(carro);

    if(carExist) {
      db.deleteCarro(carro.id);
    } else {
      int id = await db.saveCarro(carro);
      print("Carro Salvo $id");
    }

    setState(() {
      _isFavorito = !carExist;
    });

  }

}
