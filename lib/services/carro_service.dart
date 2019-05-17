import 'package:cars/model/carro.dart';

class CarroService {

  static List<Carro> getCarros() {

    var url1 = "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png";
    var url2 = "https://abrilquatrorodas.files.wordpress.com/2019/02/dc5aeab5-ferrari-f8-tributo-1.jpg";
      final carros = List.generate(50, (idx) {
          return Carro("Ferrari $idx", url1);
      });

      return carros;
  }
}