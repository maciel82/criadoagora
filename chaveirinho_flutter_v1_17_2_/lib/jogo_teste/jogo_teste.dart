import 'package:chaveirinho_flutter_v1_17_2_/jogo_teste/questoes.dart';
import 'package:chaveirinho_flutter_v1_17_2_/jogo_teste/valida.dart';
import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {

  Valida valida = Valida();

  int valorList;
  String vlist;
  List listaP = ["1", "2", "3"];

  List listaQuestoes = ["primeira", "segunda", "terceira"];

  void setList(){
    
  }
  
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
                  itemCount: listaP.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: CircleAvatar(
                        child: Text(listaP[index]),                        
                      ),
                      onTap: (){
                        //pega valor da posição da lista
                        String vList = listaP[index];
                        valorList = int.parse(vList) - 1;
                        vlist = listaQuestoes[valorList];
                        valida.setList = vlist;
                        
                        print("vlist: $vlist");                        
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QuestoesJogoTeste()));
                        print("v: $valorList");
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