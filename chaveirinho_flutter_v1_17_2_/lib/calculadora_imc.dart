import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Calculadora de IMC",
    home: CalculadoraIMC(),
  ));
}

class CalculadoraIMC extends StatefulWidget {
  @override
  _CalculadoraIMCState createState() => _CalculadoraIMCState();
}

class _CalculadoraIMCState extends State<CalculadoraIMC> {

  TextEditingController _controllerPeso = TextEditingController();
  TextEditingController _controllerAltura = TextEditingController();
  String _infor = "";

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  void _reset(){
    _controllerPeso.text = "";
    _controllerAltura.text = "";
    setState(() {
      _infor = "";
    });
  }

  void calcularIMC(){
    setState(() {
      double _peso = double.parse(_controllerPeso.text);
      double _altura = double.parse(_controllerAltura.text) / 100;
      double imc = _peso / (_altura * _altura);
      _infor = imc.toStringAsPrecision(3);
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("data"),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh), 
            color: Colors.white,
            onPressed: (){
              _reset();
            }
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 120, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso(kg)",
                  labelStyle: TextStyle(color: Colors.green, fontSize: 30),
                ),
                textAlign: TextAlign.center,
                controller: _controllerPeso,
                validator: (value){
                  if (value.isEmpty) {
                    return "preencha o campo";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura(cm)",
                  labelStyle: TextStyle(color: Colors.green, fontSize: 30),
                ),
                textAlign: TextAlign.center,
                controller: _controllerAltura,
                validator: (value){
                  if (value.isEmpty) {
                    return "preencha o campo";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: RaisedButton(
                  onPressed: (){
                    if (_globalKey.currentState.validate()) {
                      calcularIMC();
                    }
                  },
                  child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25.0),),
                  color: Colors.green,
                ),
              ),
              Center(child: Text(_infor, style: TextStyle(color: Colors.green, fontSize: 20.0),))
            ],
          ),
        ),
      ),
    );
  }
}