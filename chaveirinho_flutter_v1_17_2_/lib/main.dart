import 'package:chaveirinho_flutter_v1_17_2_/buscador_gifs.dart';
import 'package:chaveirinho_flutter_v1_17_2_/calculadora_imc.dart';
import 'package:chaveirinho_flutter_v1_17_2_/contador_de_pessoas.dart';
import 'package:chaveirinho_flutter_v1_17_2_/conversor_de_moeda.dart';
import 'package:chaveirinho_flutter_v1_17_2_/cronometro.dart';
import 'package:chaveirinho_flutter_v1_17_2_/jogo_teste/jogo_teste.dart';
import 'package:chaveirinho_flutter_v1_17_2_/lista.dart';
import 'package:chaveirinho_flutter_v1_17_2_/pergunte.dart';
import 'package:chaveirinho_flutter_v1_17_2_/simlpes_cronometro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: GradientAppBar(
          title: Text("Lista de Programas"),
          gradient: LinearGradient(colors: [Colors.blue[800], Colors.blue[400], Colors.blue[800]]),
          centerTitle: true,
        ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.3, 0.8, 0.9, 1.0],
              colors: [Colors.blue, Colors.red[300], Colors.red[400], Colors.red])
          ),
          child: Column(
            children: <Widget>[
              Expanded(
              child: ListView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      title: Text("Contador de Pessoas", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      leading: FlutterLogo(size: 50,),
                      trailing: Icon(Icons.touch_app),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ContadorDePessoas()));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text("Calculadora de IMC", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      leading: FlutterLogo(size: 50,),
                      trailing: Icon(Icons.touch_app),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CalculadoraIMC()));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text("Conversor de moedas", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      leading: FlutterLogo(size: 50,),
                      trailing: Icon(Icons.touch_app),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ConversorPr()));
                      },
                    ),
                  ),

                  Card(
                    child: ListTile(
                      title: Text("Lista de Terefas", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,),
                      leading: FlutterLogo(size: 50,),
                      trailing: Icon(Icons.touch_app),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Lista()));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text("Pergunte!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,),
                      leading: FlutterLogo(size: 50),
                      trailing: Icon(Icons.touch_app),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Pergunte()));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text("Buscador GIPHY", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center),
                      leading: FlutterLogo(size: 50,),
                      trailing: Icon(Icons.touch_app),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Gifs()));
                      },
                    )
                  ),
                  Card(
                    child: ListTile(
                      title: Text("Cronômetro", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center),
                      leading: FlutterLogo(size: 50,),
                      trailing: Icon(Icons.touch_app),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text("Simples Cronômetro", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center),
                      leading: FlutterLogo(size: 50,),
                      trailing: Icon(Icons.touch_app),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SimplesCronometro()));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text("Jogo Teste", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center),
                      leading: FlutterLogo(size: 50,),
                      trailing: Icon(Icons.touch_app),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Jogo()));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(""),
                      leading: FlutterLogo(size: 50,),
                      trailing: Icon(Icons.touch_app),
                      onTap: (){},
                    ),
                  )
                ],
              ), 
            ),
            ],
          ),
        ),
      ),
    );
  }
}