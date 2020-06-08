import 'package:chaveirinho_flutter_v1_17_2_/jogo_teste/questoes.dart';
import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {

  int posListaP;
  String vListQuestoes;
  String vListListaP;
  List listaP = ["1", "2", "3", "4"];

  Icon check = Icon(Icons.check);
  Icon lock = Icon(Icons.lock);

  List listaQuestoes = ["primeira", "segunda", "terceira", "quarta"];

  void mudaIcon(){
    setState(() {
      
    });
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
                    crossAxisCount: 4,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0
                  ),
                  itemCount: listaP.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: GestureDetector(
                        child: Container(
                          child: check
                        ),
                        onTap: (){
                          //pega valor da posição da lista
                          vListListaP = listaP[index];
                          posListaP = int.parse(vListListaP) - 1;
                          vListQuestoes = listaQuestoes[posListaP];

                          listaP[index] = true;
                          
                          print("vlist: $vListListaP");                        
                          Navigator.push(context, MaterialPageRoute(builder: (context) => QuestoesJogoTeste(this.vListQuestoes)));
                          print("v: $posListaP");
                        },
                      ),
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