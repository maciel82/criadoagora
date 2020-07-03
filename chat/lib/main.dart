import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async{
  runApp(MyApp());

  /* setando dados no firebase
  
  Firestore.instance.collection('mensagens').document('msg1')
  .setData({
     'texto': 'olá, tudo bem?', 
     'from': 'Maciel',
     'read': false
  });*/

  /*atualizando dados no firebase
  
  Firestore.instance.collection('mensagens').document('msg1')
  .updateData({
     'texto': 'sim!', 
  });*/

  /*obtem todos os dados
  
  QuerySnapshot snapshot = await Firestore.instance.collection('mensagens').getDocuments();
  snapshot.documents.forEach((element) {
    print(element.data); //escreve o dados
    print(element.documentID); //escreve o id do dado
    //element.reference.updateData({'read': true}); //modifica o campo
  });*/

  /*obtem dado a partir do id
  
  DocumentSnapshot snapshot = await Firestore.instance.collection('mensagens').document('msg1').get();
  print(snapshot.data);
  */

  /*ler todos os documentos em tempo real
  
  Firestore.instance.collection('mensagens').snapshots().listen((event) {
    event.documents.forEach((element) {
      print(element.data);
    });
  });*/

  /*ler dado do documento em específico
  
  Firestore.instance.collection('mensagens').document('msg1').snapshots().listen((event) {
    print(event.data);
  });*/

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}