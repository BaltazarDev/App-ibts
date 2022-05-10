import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';

import 'Constants/constant.dart';
import 'Home/home.dart';
import 'Home/principal.dart';
import 'Llamar/llamarAgente.dart';


class ListaRest {
  final String id;
  final String descripcion, npedimento, psalida,
      pdestino, estatus,fechapedido, hora, imageUrl;

  ListaRest({
    required this.id,
    required this.descripcion,
    required this.npedimento,
    required this.psalida,
    required this.pdestino,
    required this.estatus,
    required this.fechapedido,
    required this.hora,
    required this.imageUrl,
  });

  factory ListaRest.fromJson(Map<String, dynamic> jsonData) {
    return ListaRest(
      id: jsonData['id'],
      descripcion: jsonData['descripcion'],
      npedimento: jsonData['npedimento'],
      psalida: jsonData['psalida'],
      pdestino: jsonData['pdestino'],
      estatus: jsonData['estatus'],
      fechapedido: jsonData['fechapedido'],
      hora: jsonData['hora'],
      imageUrl: "http://192.168.1.65/RestJWT/public/assets/img/"+jsonData['image_url'],
      //imageUrl: "http://192.168.1.65/FlutterMysql/images/"+jsonData['image_url'],
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<ListaRest> listasrest;

  CustomListView(this.listasrest);

  Widget build(context) {
    return ListView.builder(
      itemCount: listasrest.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(listasrest[currentIndex], context);
      },
    );
  }

  Widget createViewItem(ListaRest listarest, BuildContext context) {
    return new ListTile(
        title: new Card(
          color: nBackgroundColor,
          elevation: 5.0,
          child: new Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: nPrimaryColor)),
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Padding(
                  //child: Image.network(listarest.imageUrl),
                  padding: EdgeInsets.only(bottom: 5.0),
                ),
                Row(children: <Widget>[
                  Text(
                      "Descripción: ",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white)
                  ),
                  Padding(
                      child: Text(
                        listarest.descripcion,
                        style: new TextStyle(
                          //fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)
                  ),
                ]),
                Row(children: <Widget>[
                  Text(
                      "No.Pedido: ",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white)
                  ),
                  Padding(
                      child: Text(
                        listarest.npedimento,
                        style: new TextStyle(
                          //fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)
                  ),
                ]),
                Row(children: <Widget>[
                  Text(
                      "Puerto de salida: ",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white)
                  ),
                  Padding(
                      child: Text(
                        listarest.psalida,
                        style: new TextStyle(
                          //fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)
                  ),
                ]),
                Row(children: <Widget>[
                  Text(
                      "Puerto de destino: ",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white)
                  ),
                  Padding(
                      child: Text(
                        listarest.pdestino,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)
                  ),
                ]),
                Row(children: <Widget>[
                  Text(
                      "Estatus: ",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white)
                  ),
                  Padding(
                      child: Text(
                        listarest.estatus,
                        style: new TextStyle(
                          //fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)
                  ),
                ]),
                Row(children: <Widget>[
                  Text(
                      "Fecha del pedido: ",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white)
                  ),
                  Padding(
                      child: Text(
                        listarest.fechapedido,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)
                  ),
                ]),
                Row(children: <Widget>[
                  Text(
                      "Hora del pedido: ",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white)
                  ),
                  Padding(
                      child: Text(
                        listarest.hora,
                        style: new TextStyle(
                          //fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)
                  ),
                ]),
              ],
            ),
          ),
        ),
        onTap: () {
          //We start by creating a Page Route.
          //A MaterialPageRoute is a modal route that replaces the entire
          //screen with a platform-adaptive transition.
          var route = new MaterialPageRoute(
            builder: (BuildContext context) =>
            new SecondScreen(value: listarest),
          );
          //A Navigator is a widget that manages a set of child widgets with
          //stack discipline.It allows us navigate pages.
          Navigator.of(context).push(route);
        });
  }
}

//Future is n object representing a delayed computation.
Future<List<ListaRest>> downloadJSON() async {
  final jsonEndpoint = Uri.parse("http://192.168.1.65/RestJWT/public/api/pedidos/");

  final response = await get(jsonEndpoint);

  if (response.statusCode == 200) {
    List listasrest = json.decode(response.body);
    return listasrest
        .map((listarest) => new ListaRest.fromJson(listarest))
        .toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

class SecondScreen extends StatefulWidget {
  final ListaRest value;

  SecondScreen({Key? key, required this.value}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //backgroundColor: nBackgroundColor,
      appBar: new AppBar(title: new Text('Detalles'),
        backgroundColor: nPrimaryColor,
      ),

      body: new Container(
        child: new Center(
          child: Column(
            children: <Widget>[
              Padding(
                //child: new Text(
                //'Detalles',
                //style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                //textAlign: TextAlign.center,
                //),
                padding: EdgeInsets.only(bottom: 20.0),
              ),
              Padding(
                //`widget` is the current configuration. A State object's configuration
                //is the corresponding StatefulWidget instance.
                child: Image.network('${widget.value.imageUrl}'),
                padding: EdgeInsets.all(12.0),
              ),
              Padding(
                child: new Text(
                  'NAME : ${widget.value.npedimento}',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                padding: EdgeInsets.all(20.0),
              ),
              Padding(
                child: new Text(
                  'PROPELLANT : ${widget.value.descripcion}',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                padding: EdgeInsets.all(20.0),
              )
            ],   ),
        ),
      ),
    );
  }
}

class Polizas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        //primarySwatch: Colors.deepOrange,
      ),
      home: new Scaffold(
        backgroundColor: nBackgroundColor,
        appBar: AppBar(title: Text("Historial"),
            backgroundColor: nPrimaryColor),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                child: DrawerHeader(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: AssetImage("assets/images/LogoBTTS3.png")
                      )
                  ), child: null,
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Inicio'),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (BuildContext context) => Inicio())
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.map),
                title: Text('Polizas'),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (BuildContext context) => Polizas())
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.calculate),
                title: Text('Llamar a un agente'),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (BuildContext context) => Llamada())
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.power_settings_new),
                title: Text('Salir'),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute<Null>(
                      builder: (BuildContext context){
                        return new HomeScreen();
                      }
                  ), (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
        body: new Center(
          //FutureBuilder is a widget that builds itself based on the latest snapshot
          // of interaction with a Future.
          child: new FutureBuilder<List<ListaRest>>(
            future: downloadJSON(),
            //we pass a BuildContext and an AsyncSnapshot object which is an
            //Immutable representation of the most recent interaction with
            //an asynchronous computation.
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ListaRest>? listasrest = snapshot.data;
                return new CustomListView(listasrest!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              //return  a circular progress indicator.
              return new CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.cyan),
              );
            },
          ),

        ),
      ),
    );
  }
}

void main() {
  runApp(Polizas());
}