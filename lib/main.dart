import 'package:News_App/screens/Welcome/welcome_screen.dart';
import 'package:News_App/views/home.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/services.dart';

import 'internet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var i = 0;
    return new MaterialApp(
      title: 'My Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: homie(),
    );
  }
}

class homie extends StatefulWidget {
  @override
  _homieState createState() => _homieState();
}

class _homieState extends State<homie> {
  ConnectivityResult previous;
  @override
  void initState() {
    super.initState();
    try {
      InternetAddress.lookup('google.com').then((result) {
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => imageui(),
          ));
        } else {
          _showdialog();
        }
      }).catchError((error) {
        _showdialog();
      });
    } on SocketException catch (_) {
      // no internet
      _showdialog();
    }
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connresult) {
      if (connresult == ConnectivityResult.none) {
      } else if (previous == ConnectivityResult.none) {
        // internet conn
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => imageui(),
        ));
      }

      previous = connresult;
    });
  }

  void _showdialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text('ERROR'),
        content: Text("No Internet Detected."),
        actions: <Widget>[
          FlatButton(
            color: Colors.black,
            // method to exit application programitacally
            onPressed: () =>
                SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            child: Text("Exit"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text("Checking Your Internet Connection."),
            ),
          ],
        ),
      ),
    );
  }
}
