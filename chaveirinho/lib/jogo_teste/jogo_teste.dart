import 'dart:convert';
import 'dart:io';

import 'package:chaveirinho/jogo_teste/questoes.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
    super.initState();

    print("verificaListaInit: $verificaLista");

    if (verificaLista.isEmpty) {
      for (var i = 0; i < listaP.length; i++) {            
        checkList();      
      }
    }   

    readData().then((data){
      setState(() {
        verificaLista = json.decode(data);
        print("verificaListaRead: $verificaLista");
      });
    });    
  }

  checkList() {
    setState(() {
      posListaP = 0;
      Map<String, dynamic> addList = Map();
      addList["title"] = listaP[posListaP];
      verificaLista.add(addList);
      print("verificaListaChelist: $verificaLista");
      addList["ok"] = false;
      verificaLista[0]["ok"] = true;
      saveData();
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
                  itemCount: verificaLista.length,
                  itemBuilder: (BuildContext context, int index) {                    
                    return Card(
                      child: GestureDetector(
                        child: Stack(
                          children: <Widget>[
                            verificaLista[index]["ok"]? nonePos0 : lock,
                            Container(
                              child: Center(child: Text(listaP[index], style: TextStyle(fontSize: 20.0),)),
                            )
                          ],
                        ),
                        onTap: (){
                          //pega valor da posição da lista
                          vListListaP = listaP[index];
                          posListaP = index; //int.parse(vListListaP) - 1;
                          vListQuestoes = listaQuestoes[posListaP];

                          setState(() {
                            verificaLista[index]["ok"] = true;
                            saveData();
                          });                          

                          print(posListaP);
                          print("verificaListaBuild: $verificaLista");
                                                                            
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

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data5.json");
  }

  Future<File> saveData() async {
    String data = json.encode(verificaLista);

    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future readData() async {
    try {
      final file = await _getFile();

      return file.readAsString();
    } catch(e) {
    }
  }
}