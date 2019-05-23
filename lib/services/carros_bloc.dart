import 'dart:async';
import 'package:cars/model/carro.dart';
import 'carro_service.dart';

class CarrosBloc {

  final _controller = StreamController();

  get stream => _controller.stream;

  Future fetchCarros(tipo) {

    //Consulta os carros
    Future<List<Carro>> futureListCar = CarroService.getCarros(tipo);

    //Quando o future retornar resultados adiciona no Controller do Stream
    futureListCar.then((carros) {
      _controller.sink.add(carros);
    }).catchError((error) {
      _controller.addError(error);
    });

    return futureListCar;
  }

  void close() {
    _controller.close();
  }
}