import 'package:chaveirinho_flutter_v1_17_2_/jogo_teste/questoes.dart';
import 'package:chaveirinho_flutter_v1_17_2_/jogo_teste/valida.dart';
import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {

  Valida _valida = Valida();

  int valorList;

  List lista = ["1", "2", "3", "4", "5", "6", "7", "8",
   "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "images/lista.jpeg"
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.fromLTRB(40.0, 45.0, 40.0, 0.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0
                  ),
                  itemCount: lista.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: CircleAvatar(
                        child: Text(lista[index]),                        
                      ),
                      onTap: (){
                        //pega valor da posição da lista
                        String vList = lista[index];
                        valorList = int.parse(vList) - 1;
                        _valida.setList = valorList;                        
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QuestoesJogoTeste()));
                        print("v: ");
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}