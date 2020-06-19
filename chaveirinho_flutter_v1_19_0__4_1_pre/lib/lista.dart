import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {

  List toDoList = [];

  final _controllerTextADD = TextEditingController();

  int listRemodiaPos;
  Map<String, dynamic> listRemovida;

  @override
  void initState() {
    super.initState();
    readData().then((data){
      setState(() {
        toDoList = json.decode(data);
      });
    });
  }

  void addLista(){
    setState(() {
      Map<String, dynamic> addToDo = Map();
      addToDo["title"] = _controllerTextADD.text;
      toDoList.add(addToDo);
      _controllerTextADD.text = "";
      addToDo["ok"] = false;
      saveData();
    });
  }

  Future<Null> _refresh() async{
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      toDoList.sort((a, b){
        if (a["ok"] && !b["ok"]) return 1;
        else if(!a["ok"] && b["ok"]) return -1;
        else return 0;
      });

      saveData();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: <Widget>[
          Row( 
            children: <Widget>[ 
              Expanded(
                child: TextField(
                 decoration: InputDecoration(
                   labelText: "Nova tarefa",
                   labelStyle: TextStyle(color: Colors.blueAccent)
                 ), 
                 controller: _controllerTextADD,
                )
              ),
              RaisedButton(
                onPressed: (){
                  addLista();
                },
                child: Text("ADD"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
            ],
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                itemCount: toDoList.length,
                itemBuilder: buildItem
              ),
            )
          )
        ],
      ),
    );
  }

  Widget buildItem(context, indice){
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(toDoList[indice]["title"]),
        value: toDoList[indice]["ok"],
        secondary: CircleAvatar(
          child: Icon(toDoList[indice]["ok"]? Icons.check_circle : Icons.error),
        ),
        onChanged: (c){
          setState(() {
            toDoList[indice]["ok"] = c;
            saveData();
          });
        }
      ),

      onDismissed: (babuleta){
        listRemovida = Map.from(toDoList[indice]);
        listRemodiaPos = indice;
        toDoList.removeAt(indice);

        saveData();

        final snack = SnackBar(
          content: Text("Tarefa \"${listRemovida["title"]}\" removida!", style: TextStyle(color: Colors.green)),
          action: SnackBarAction(
            onPressed: (){
              setState(() {
                toDoList.insert(indice, listRemovida);
                saveData();
              });
            },
            label: "Desfazer",
          ),
          duration: Duration(seconds: 5),
        );

        Scaffold.of(context).showSnackBar(snack);
      },
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> saveData() async {
    String data = json.encode(toDoList);

    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future readData() async {
    try {
      final file = await _getFile();

      return file.readAsString();
    } catch (e) {
    }
  }
}

