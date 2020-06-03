import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json-cors&key=d46eb9ba";

class ConversorPr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Conversor(),
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        )
      ),
    );
  }
}

Future<Map> getData() async{
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Conversor extends StatefulWidget {
  @override
  _ConversorState createState() => _ConversorState();
}

class _ConversorState extends State<Conversor> {

  double dolar;
  double euro;
  double real;

  TextEditingController _controllerReal = TextEditingController();
  TextEditingController _controllerDolar = TextEditingController();
  TextEditingController _controllerEuro = TextEditingController();

  void clearAll(){
    _controllerReal.text = "";
    _controllerDolar.text = "";
    _controllerEuro.text = "";
  }

  void dolarChanged(String text){
    if (text.isEmpty) {
      clearAll();
      return;
    }
    _controllerEuro.text = (dolar / euro).toStringAsFixed(2);
    _controllerReal.text = (dolar * real).toStringAsFixed(2);

    print(dolar);
    print(euro);
  }

  void euroChanged(String text){
    if (text.isEmpty) {
      clearAll();
      return;
    }
    _controllerReal.text = (euro * real).toStringAsFixed(2);
    _controllerDolar.text = (euro / dolar).toStringAsFixed(2);
  }

  void realChanged(String text){
    if (text.isEmpty) {
      clearAll();
      return;
    }
    real = double.parse(_controllerReal.text);
    _controllerEuro.text = (real / euro).toStringAsFixed(2);
    _controllerDolar.text = (real / dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor de Moedas \$", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text("Carregando dados...", style: TextStyle(color: Colors.amber)),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text("Erro ao carregar dados", style: TextStyle(color: Colors.amber),),
                );
              }else{
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on, size: 120.0, color: Colors.amber,),
                      widgetTextFild("Reias", "R\$ ", _controllerReal, realChanged),
                      Divider(),
                      widgetTextFild("Dólares", "US\$ ", _controllerDolar, dolarChanged),
                      Divider(),
                      widgetTextFild("Euros", "¢ ", _controllerEuro, euroChanged),
                    ],
                  ),
                );
              }
          }
        }
      ),
    );
  }
}

Widget widgetTextFild(String label, String prefix, TextEditingController c, Function f){
  return TextField(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.amber),
      border: OutlineInputBorder(),
      prefixText: prefix
    ),
    style: TextStyle(color: Colors.amber),
    controller: c,
    onChanged:f,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}