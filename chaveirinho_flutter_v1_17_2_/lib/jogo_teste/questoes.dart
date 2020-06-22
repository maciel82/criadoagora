import 'package:chaveirinho_flutter_v1_17_2_/jogo_teste/valida.dart';
import 'package:flutter/material.dart';

class QuestoesJogoTeste extends StatefulWidget {
  String nome;
  QuestoesJogoTeste(this.nome);

  @override
  _QuestoesJogoTesteState createState() => _QuestoesJogoTesteState(this.nome);
}

class _QuestoesJogoTesteState extends State<QuestoesJogoTeste> {

  //Valida valida = Valida();

  _QuestoesJogoTesteState(this.list);

  String list = "";

  @override
  void initState() {
    /*setState(() {
      list = valida.getList;
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Center(
              child: Text("$list", style: TextStyle(fontSize: 30.0),              
              ),
            ),
          )
        ],
      ),
    );
  }
}