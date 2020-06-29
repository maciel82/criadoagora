import 'package:flutter/material.dart';

class ContadorDePessoas extends StatefulWidget {
  @override
  _ContadorDePessoasState createState() => _ContadorDePessoasState();
}

class _ContadorDePessoasState extends State<ContadorDePessoas> {

  int numPessoas = 0;
  String podeSouN = "";

  void _contagem(int num){
    setState(() {
      numPessoas += num;
      if (numPessoas <= 0) {
        podeSouN = "Lotado";
      } else {
        podeSouN = "Pode entrar!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "images/original.jpg",
            fit: BoxFit.cover,
            height: 1000,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Pessoas $numPessoas", style: TextStyle(fontSize: 45, color: Colors.white),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      _contagem(1);
                    },
                    child: Text("+1", style: TextStyle(color: Colors.white, fontSize: 40),)
                  ),
                  FlatButton(
                    onPressed: (){
                      _contagem(-1);
                    },
                    child: Text("-1", style: TextStyle(color: Colors.white, fontSize: 40),)
                  )
                ],
              ),
              Text(podeSouN, style: TextStyle(fontSize: 25, color: Colors.white),)
            ],
          ),
        ],
      ),
    );
  }
}