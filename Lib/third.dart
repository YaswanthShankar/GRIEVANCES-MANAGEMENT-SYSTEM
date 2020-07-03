import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_sign/SecondScreen.dart';
//import 'package:http/http.dart' as http;

class ThirdScreen extends StatefulWidget {
  final Gerven gerven;

  ThirdScreen({this.gerven});

  @override
  _ThirdScreen createState() => _ThirdScreen();
}

class _ThirdScreen extends State<ThirdScreen> {
   
  @override
  Widget build(BuildContext context) {
     Uint8List bytes = base64.decode(widget.gerven.image);
    return Scaffold(
      appBar: AppBar(title: Text('greven')),
      body:SingleChildScrollView(
      
        child: Column( children: <Widget>[
      Card(
          elevation: 5.0,
          child: new Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title:
                      Text("PROBLEM DESCRIPTION : ${widget.gerven.description}",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          )),
      
        Card(
            elevation: 5.0,
            child: new Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.orange)),
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.all(20.0),
              
                 
                   
                    
          child: Image.memory(bytes),
          
        
            ))  ,
            Card(
              elevation: 5.0,
              child: Container(

                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange)
                ),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                child: Column(
              children: <Widget>[
                ListTile(
                  title:
                      Text("Updated Date and Time : ${ widget.gerven.date}",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                ),
              ],
            ),
              ),
            ),
           Divider(),
          
                ]),
                
    ));
    
  }
}

