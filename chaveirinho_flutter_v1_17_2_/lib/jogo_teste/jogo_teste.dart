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
  bool chequeIsso;
  List verificaLista = [];

  Icon check = Icon(Icons.check);
  Icon lock = Icon(Icons.lock);
  Icon nonePos0 = Icon(Icons.remove_red_eye);

  List listaQuestoes = ["primeira", "segunda", "terceira", "quarta"];

  @override
  void initState() {
    setState(() {
      posListaP = 0;
      Map<String, dynamic> addList = Map();
      addList["title"] = listaP[posListaP];
      verificaLista.add(addList);
      addList["ok"] = false;
      verificaLista[0]["ok"] = true;
    });
    super.initState();
  }

  void checkList(){
    Map<String, dynamic> addList = Map();
    addList["title"] = listaP[posListaP];
    verificaLista.add(addList);
    addList["ok"] = false;
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
                  itemCount: verificaLista.length,
                  itemBuilder: (BuildContext context, int index) {                    
                    return Card(
                      child: GestureDetector(
                        child: Stack(
                          children: <Widget>[
                            verificaLista[0]["ok"]? nonePos0 : lock,
                            Container(
                              child: Center(child: Text(verificaLista[index]["title"], style: TextStyle(fontSize: 20.0),)),
                            )
                          ],
                        ),
                        onTap: (){
                          //pega valor da posição da lista
                          vListListaP = listaP[index];
                          posListaP = index; //int.parse(vListListaP) - 1;
                          vListQuestoes = listaQuestoes[posListaP];

                          print(posListaP);
                                                                            
                          Navigator.push(context, MaterialPageRoute(builder: (context) => QuestoesJogoTeste(this.vListQuestoes)));                            
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