import 'package:flutter/material.dart';
import 'dart:async';

class SimplesCronometro extends StatefulWidget {
  @override
  _SimplesCronometroState createState() => _SimplesCronometroState();
}

class _SimplesCronometroState extends State<SimplesCronometro> {
  final _timeOut = const Duration(seconds: 1);
  final _stopWatch = Stopwatch();
  String _buttonText = "Start";
  String _stopoWatchText = "00:00:00";

  void _startTimeOut() {
    new Timer(_timeOut, _handleTimeOut);
  }

  void _handleTimeOut() {
    if (_stopWatch.isRunning) {
      _startTimeOut();
    }
    setState(() {
      _setStopwatchText();
    });
  }

  void _startStop(){
    setState(() {
      if (_stopWatch.isRunning) {
        _buttonText = "Start";
        _stopWatch.stop();

      } else {
        _buttonText = "Stop";
        _stopWatch.start();
        _startTimeOut();
      }
    });
  }

  void _resetButtonPressed(){
    if(_stopWatch.isRunning){
      _startStop();
    }
    setState(() {
     _stopWatch.reset();
     _setStopwatchText(); 
    });
  }

  void _setStopwatchText(){
    _stopoWatchText = _stopWatch.elapsed.inHours.toString().padLeft(2,'0') + ':'+
                     (_stopWatch.elapsed.inMinutes%60).toString().padLeft(2,'0') + ':' +
                     (_stopWatch.elapsed.inSeconds%60).toString().padLeft(2,'0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simples Cronômetro"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text(_buttonText), 
          onPressed: _startStop,
        ),
        RaisedButton(
          child: Text("Reset"),
          onPressed: _resetButtonPressed,
        ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.none,
            child: Text(
              _stopoWatchText,
              style: TextStyle(fontSize: 72),
            ),
          )
        )
      ],
    );
  }
}
