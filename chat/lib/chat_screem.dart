import 'package:chat/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreem extends StatefulWidget {
  @override
  _ChatScreemState createState() => _ChatScreemState();
}

class _ChatScreemState extends State<ChatScreem> {

  void _sendMessage(String text){
    Firestore.instance.collection('messages').add({
      'text' : text
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("oi"),
        actions: <Widget>[

      ],),
      body: TextComposer(
        _sendMessage       
      ),
    );
  }
}