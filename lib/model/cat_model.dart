//Clase que representa un modelo o entidad del negocio
class GetFact {
  String id;
  String text;

  GetFact({
    this.id,
    this.text,
  });

  //Este metodo es para convertir en mapa el objecto para luego transformarlo en json
  Map<String, dynamic> toMap() {
    return {
      'Id': this.id,
      "text": this.text,
    };
  }

  //Este metodo es para crear un nuevo usando el mapa que se crea al leer un json
  factory GetFact.fromMap(Map data) {
    data = data ?? {};
    return GetFact(
      id: data['_id'] ?? '',
      text: data['text'] ?? '',
    );
  }
}
