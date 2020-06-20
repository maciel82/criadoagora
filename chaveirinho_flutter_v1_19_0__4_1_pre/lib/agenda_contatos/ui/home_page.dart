import 'dart:io';

import 'package:chaveirinho_flutter_v1_19_0__4_1_pre/agenda_contatos/helper/contact_helper.dart';
import 'package:chaveirinho_flutter_v1_19_0__4_1_pre/agenda_contatos/ui/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

    _getAllContacts();
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
        onPressed: (){
          _showContactPage();
        },
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
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[item].img != null ? FileImage(File(contacts[item].img)) : AssetImage("images/person.png"),
                    fit: BoxFit.cover
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
      onTap: (){
        _showOptions(context, item);
      },
    );
  }

  _showOptions(BuildContext context, int index){
    showModalBottomSheet(
      context: context, 
      builder: (context){
        return BottomSheet(
          onClosing: (){}, 
          builder: (context){
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: (){
                      launch("tel: ${contacts[index]}");
                      Navigator.pop(context);
                    }, 
                    child: Text("Ligar", style: TextStyle(color: Colors.green),)
                  ),
                  FlatButton(
                    onPressed: (){
                      Navigator.pop(context);
                      _showContactPage(contact: contacts[index]);                      
                    }, 
                    child: Text("Editar", style: TextStyle(color: Colors.blue))
                  ),
                  FlatButton(
                    onPressed: (){
                      helper.deleteContact(contacts[index].id);
                      setState(() {
                        contacts.removeAt(index);
                        Navigator.pop(context);
                      });
                    }, 
                    child: Text("Exluir", style: TextStyle(color: Colors.red))
                  )
                ],
              ),
            );
          },
        );
      }
    );
  }

  void _showContactPage({Contact contact}) async{
    final recContact = await Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage(contact: contact)));
    if (recContact != null) {
      if (contact != null) {
        helper.updateContact(recContact);
      } else {
        helper.saveContact(recContact);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts(){
    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }
}