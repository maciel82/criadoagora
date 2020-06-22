import 'dart:math';

import 'package:chaveirinho_flutter_v1_17_2_/model/questoes.dart';
import 'package:flutter/material.dart';

class Pergunte extends StatefulWidget {
  @override
  _PergunteState createState() => _PergunteState();
}

class _PergunteState extends State<Pergunte> {
  Questoes _questoes = Questoes();
  int _length;

  String textPergunta = "";
  String botaoA = "";
  String botaoB = "";
  String respostaCerta = "";
  String r = "";
  Random _random = Random();

  @override
  void initState() {
    updateQuestoes(1);
    super.initState();
  }

  Future<Null> updateQuestoes(int _num) async{    
    _length = _questoes.perguntas.length;
    setState(() {
      textPergunta = _questoes.getPerguntas(_num);
      botaoA = _questoes.getEscolhasA(_num);
      botaoB = _questoes.getEscolhasB(_num);
      respostaCerta = _questoes.respostaCerta(_num);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Text(textPergunta, style: TextStyle(fontSize: 40),)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: (){
                    if (botaoA == respostaCerta) {
                      r = "certa";
                    } else {
                      r = "errada";
                    }
                    updateQuestoes(_random.nextInt(_length));
                  },
                  child: Text(botaoA),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: (){                    
                    if (botaoB == respostaCerta) {
                      r = "certa";
                    } else {
                      r = "errada";
                    }
                    updateQuestoes(_random.nextInt(_length));
                  },
                  child: Text(botaoB),
                ),
              ),
            ],
          ),

          Text("A resposta está: $r")
        ],
      ),
    );
  }
}
