import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cats_facts/model/cat_model.dart';
import 'package:my_cats_facts/service/cat_service.dart';

void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  CatsService _catsService;

  @override
  void initState() {
    super.initState();
    this._catsService = CatsService();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Listviews"),
      ),
      body: FutureBuilder<List<GetFact>>(
        future: _catsService.getList(),
        builder: (context, snapshot) {
          //Validamos que se ejecute correctamente el futuro y termine
          if (snapshot.connectionState == ConnectionState.done) {
            //Validar si el contenido no esta vacio
            if (snapshot.data != null && snapshot.data.isNotEmpty) {
              //Creamos el contenido de la lista
              return buildContent(context, snapshot.data);
            }

            //Notificamos q no se encontraron registros
            return Center(
                child: ListTile(
              leading: Icon(Icons.warning),
              title: Text('No se encontraron registros.'),
            ));
          }

          //Si no ha terminado la llamada retornamos idicador de loading
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(),
                ),
                Text('Cargando...'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildContent(BuildContext context, List<GetFact> catsTypeList) {
    return ListView.builder(
      itemCount: catsTypeList != null ? catsTypeList.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          // height: 180,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Expanded(
                      child: new Card(
              elevation: 10,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Id:',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${catsTypeList[index].id}',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Text:'),
                      Flexible(
                        flex: 1,
                                            child: Text(
                                              
                          catsTypeList[index].text,
                          textAlign: TextAlign.justify,
                          // overflow: TextOverflow.ellipsis,   ( oculta texto)
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
