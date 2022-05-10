import 'package:flutter/material.Dart';
import 'package:flutter/material.dart';
import 'package:insurence_ibts/Constants/constant.dart';
import 'package:url_launcher/url_launcher.Dart';

class Llamada extends StatelessWidget {
  Llamada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => new Scaffold(
    backgroundColor: nBackgroundColor,
    appBar: new AppBar(
      title: new Text("Llamar a un agente"),
      backgroundColor: nPrimaryColor,
    ),
    body: new Center(
      child: new TextButton(
          onPressed: () => launch("tel://0000000000"),
          child: new Text("Llamar a un agente",
            style: TextStyle(
            color: nPrimaryColor,
          ),
          ),
      ),
    ),
  );
}

void main() {
  runApp(
    new Llamada(),
  );
}