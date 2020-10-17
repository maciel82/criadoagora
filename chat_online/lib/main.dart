import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(Home());
}

final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

final GoogleSignIn googleSignIn = GoogleSignIn();
final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

FirebaseUser _currentUser;

Future<FirebaseUser> _getUser() async{
  if(_currentUser != null) return _currentUser;

  try{
    //login no google
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    //objeto com tokens para login no firebase
    final GoogleSignInAuthentication googleSignInAutentication = await googleSignInAccount.authentication;

    //credenciais do firebase
    final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAutentication.idToken, accessToken: googleSignInAutentication.accessToken);

    //login no firebase
    final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);

    //objeto com seu usuário
    final FirebaseUser myUser = authResult.user;
    return myUser;
  }catch(error){
    return null;
  }
}

void _sendMessage({String text, File imgFile}) async{

  final FirebaseUser user = await _getUser();

  if(user == null){
    _globalKey.currentState.showSnackBar(
      SnackBar(
        content: Text("não foi possivel logar."),
        backgroundColor: Colors.red,
      )
    );
  }

  Map<String, dynamic> data = {
    "uid" : user.uid,
    "senderName" : user.displayName,
    "senderPhotorUrl" : user.photoUrl,
  };

  if(imgFile != null){
    StorageUploadTask task = FirebaseStorage.instance.ref().child(
      DateTime.now().millisecondsSinceEpoch.toString()
    ).putFile(imgFile);

    StorageTaskSnapshot taskSnapshot = await task.onComplete;
    String url = await taskSnapshot.ref.getDownloadURL();
    data['imgUrl'] = url;
  }

  if(text != null) data["text"] = text;

  Firestore.instance.collection("messages").add(data);
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat Online",
      theme: Theme.of(context).platform == TargetPlatform.iOS
          ? null
          : kDefaultTheme,
      home: ChatOnline(),
    );
  }
}

class ChatOnline extends StatefulWidget {
  @override
  _ChatOnlineState createState() => _ChatOnlineState();
}

class _ChatOnlineState extends State<ChatOnline> {

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      _currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        key: _globalKey,
        appBar: AppBar(
          title: Text("Chat App"),
          centerTitle: true,
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        actions: [

        ],
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: Firestore.instance.collection("messages").snapshots(),
                builder: (context, snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator()
                      );
                    default:
                      return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index){
                          List r = snapshot.data.documents.reversed.toList();
                          return ChatMessenger(r[index].data);
                        }                                             
                      );
                  }
                }
              )              
            ),
            Divider(
              height: 6.0,
            ),
            Container(
              decoration: BoxDecoration(
                color:Theme.of(context).cardColor
              ),
              child: TextComposer()
            )
          ],
        )
      )
    );
  }
}

class TextComposer extends StatefulWidget {
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final _textController = TextEditingController();
  bool _isComposing = false;

  void _reset(){
    _textController.clear();
    setState((){
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[200])))
            : null,
        child: Row(
          children: [
            Container(
              child:
                IconButton(icon: Icon(Icons.photo_camera), onPressed: () async{
                  final imgFile = await ImagePicker.pickImage(source: ImageSource.gallery);
                  if(imgFile == null) return;
                  _sendMessage(imgFile: imgFile);
                }),
            ),
            Expanded(
              child: TextField(
                controller: _textController,
                decoration: InputDecoration.collapsed(
                  hintText: "Escreva aqui o seu texto"),
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: (text){
                  _sendMessage(text: text);
                  _reset();
                },
              )
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: _isComposing ? () {
                  _sendMessage(text: _textController.text);
                  _reset();
                } : null),
            )
          ],
        ),
      ),
    );
  }
}

class ChatMessenger extends StatelessWidget {

  final Map<String, dynamic> data;

  ChatMessenger(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                data["senderPhotorUrl"]
              )
            ),
          ),
          Expanded(            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data["senderName"]),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: data["imgUrl"] != null ? Image.network(data["imgUrl"], width: 250,) : Text(data["text"])
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
