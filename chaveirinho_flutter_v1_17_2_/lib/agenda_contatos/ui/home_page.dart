import 'dart:io';

import 'package:chaveirinho_flutter_v1_17_2_/agenda_contatos/helper/contact_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactHelper helper = ContactHelper();

  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();

    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: _contactCard
      )
    );
  }

  Widget _contactCard(context, item){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(),
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[item].img != null ? FileImage(File(contacts[item].img)) : AssetImage("images/person.png")
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[                    
                    Text(contacts[item].name ?? "",
                      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),                              
                    ),
                    Text(contacts[item].email ?? "",
                      style: TextStyle(fontSize: 22.0),                              
                    ),
                    Text(contacts[item].phone ?? "",
                      style: TextStyle(fontSize: 22.0),                              
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}