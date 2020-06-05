import 'package:chaveirinho_flutter_v1_17_2_/jogo_teste/valida.dart';
import 'package:flutter/material.dart';

class QuestoesJogoTeste extends StatefulWidget {
  @override
  _QuestoesJogoTesteState createState() => _QuestoesJogoTesteState();
}

class _QuestoesJogoTesteState extends State<QuestoesJogoTeste> {

  Valida _valida = Valida();

  int _vList;

  List list = ["primeira", "segunda", "terceira"];

  set setList(int vList){
    _vList = vList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "mages/questoes.jpeg",
            fit: BoxFit.cover,
          ),
          Container(
            child: Text("", style: TextStyle(fontSize: 30.0),),
          )
        ],
      ),
    );
  }
}