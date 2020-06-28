import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_cats_facts/model/cat_model.dart';

class CatsService {
  //Se declaran como constanstes para no repetirlo si necesitas crear otros metodos q usen estos mismos valores
  static const String URL_CATS_FACT_LIST =
      "https://cat-fact.herokuapp.com/facts/random?animal_type=cat&amount=25";
  static const Map<String, String> HEADER = {"Accept": "application/json"};

  //Metodo que carga la lista
  //Nota: Lo ideal es que manejes paginación cuando sean listas porque si son muchos registros matas el telefono JAJAJA
  Future<List<GetFact>> getList() async {
    List<GetFact> result = [];

    try {
      print('Ejecutando el servicio');
      var response =
          await http.get(Uri.encodeFull(URL_CATS_FACT_LIST), headers: HEADER);
      print('response = $response');
      if (response != null) {
        //Convertimos el json a una lista de objectos json (Maps)
        List data = json.decode(response.body);
        print('data = ${data.length}');
        //Recorremos la lista de la data y la convertimos en nuestro objeto de negocio
        for (int i = 0; i < data.length; i++) {
          Map<String, dynamic> map = data[i];
          print('map = $map');
          GetFact factsType = GetFact.fromMap(map);
          result.add(factsType);
        }
      }

      return result;
    } on Exception catch (error) {
      print(error);
      return result;
    }
  }


}
