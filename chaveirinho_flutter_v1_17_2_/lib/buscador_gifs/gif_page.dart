import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GifPage extends StatelessWidget {

  final Map _gifMap;

  GifPage(this._gifMap);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(_gifMap["title"]),
        backgroundColor: Colors.black,
      ),
      body: Center(        
        child: Image.network(_gifMap["images"]["fixed_height_small"]["url"]),
      ),
    );
  }
}