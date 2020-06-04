import 'package:flutter/material.dart';

class QuestoesJogoTeste extends StatefulWidget {
  @override
  _QuestoesJogoTesteState createState() => _QuestoesJogoTesteState();
}

class _QuestoesJogoTesteState extends State<QuestoesJogoTeste> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "images/questoes.jpeg"
          )
        ],
      ),
    );
  }
}