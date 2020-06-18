import 'dart:io';
import 'package:chaveirinho_flutter_v1_17_2_/agenda_contatos/helper/contact_helper.dart';
import 'package:chaveirinho_flutter_v1_17_2_/agenda_contatos/ui/home_page.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {

  final Contact contact;

  ContactPage({this.contact}); //opcional

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  Contact _editedContact;

  bool userEditing = false;

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());

      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editedContact.name ?? "Novo Contato"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pop(context);
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(          
          children: <Widget>[            
            Container(      
              width: 80.0,    
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: _editedContact.img != null ? FileImage(File(_editedContact.img)) : AssetImage("images/person.png")
                )
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "nome"                
              ),
              onChanged: (text){
                userEditing = true;
                setState(() {
                  _editedContact.name = text;
                });
              },              
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "email"
              ),
              onChanged: (text){
                userEditing = true;
                _editedContact.email = text;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "phone"
              ),
              onChanged: (text){
                userEditing = true;
                _editedContact.phone = text;              
              },
              keyboardType: TextInputType.phone,
            )
          ],
        ),
        
      ),
    );
  }
}