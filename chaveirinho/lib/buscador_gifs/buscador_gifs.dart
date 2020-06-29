import 'dart:convert';

import 'package:chaveirinho/buscador_gifs/gif_page.dart';
import 'package:chaveirinho/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class Gifs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BuscadorGifs(),
      theme: ThemeData(
        primaryColor: Colors.red,
        hintColor: Colors.grey[600],
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green))
        )
      ),
    );
  }
}

class BuscadorGifs extends StatefulWidget {
  @override
  _BuscadorGifsState createState() => _BuscadorGifsState();
}

class _BuscadorGifsState extends State<BuscadorGifs> {
  String search;
  int offset = 0;

  Future<Map> searchGifs() async{
    http.Response response;

    if(search == null){
      response = await http.get("https://api.giphy.com/v1/gifs/trending?api_key=4863tchL4tTInM3yKejJifaTMy7G6Guv&limit=25&rating=G");
    }else{
      response = await http.get("https://api.giphy.com/v1/gifs/search?api_key=4863tchL4tTInM3yKejJifaTMy7G6Guv&q=$search&limit=25&offset=$offset&rating=G&lang=pt");
    }
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    searchGifs().then((map) {  
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network("https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
        leading: IconButton(
          icon: Icon(Icons.keyboard_return, color: Colors.white,), 
          onPressed: (){
            Navigator.pop(context, Home());
          }
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: TextField(
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              onSubmitted: (text){
                setState(() {
                  search = text;
                  offset = 0;
                });
              },
              decoration: InputDecoration(
                labelText: "Pesquisar",
                border: OutlineInputBorder(),
                prefix: Icon(Icons.search, color: Colors.white, size: 20),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: searchGifs(),
              builder: (context, snapshot){
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,            
                      ),
                    );
                  default:
                    if (snapshot.hasError)return Container();
                    else return _createGifTable(context, snapshot);
                }
              }
            ),
          )
        ],
      ),
    );
  }

  int _getCount(List data){
    if (search == null) {
      return data.length;
    }else{
      return data.length + 1;
    }
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0
      ),
      itemCount: _getCount(snapshot.data["data"]),
      itemBuilder: (context, index){
        if (search == null || index < snapshot.data["data"].length) {
          return GestureDetector(
            child: FadeInImage.assetNetwork(                                           
              placeholder: "images/effects.gif", 
              image: snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              height: 200.0,
              fit: BoxFit.cover,
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GifPage(snapshot.data["data"][index])));
            },
            onLongPress: (){
              Share.share(snapshot.data["data"][index]["images"]["fixed_height"]["url"]);
            },
          );
        } else {
          return Container(
            child: GestureDetector(              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,               
                children: <Widget>[                  
                  Icon(Icons.add, color: Colors.white, size: 50.0,),
                  Text("Mais imagens", style: TextStyle(fontSize: 20.0, color: Colors.white),)
                ],
              ),
              onTap: (){
                setState(() {
                  offset += 19;
                });
              }
            ),
          );
        }        
      }
    );
  }
}