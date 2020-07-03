import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_sign/SecondScreen.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  final Gerven gerven;

  UserScreen({this.gerven});

  @override
  _UserScreen createState() => _UserScreen();
}

class _UserScreen extends State<UserScreen> {
   
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
            decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
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
           Row(
             children: <Widget>[
               OutlineButton(
                 color: Colors.lightGreen,
                 child: Text("Work Status Completed",style: TextStyle(fontSize: 20.0),),
                 onPressed: () async{
                   showModalBottomSheet<String>(
                     context: context,
                     builder: (BuildContext context)=> Container(
                       decoration: BoxDecoration(
                         border: Border(top: BorderSide(color: Colors.purple)),
                       ),
                       child: ListView(
                         shrinkWrap: true,
                         primary: false,
                         children: <Widget>[
                           ListTile(
                             dense: true,
                             title: Text("Are yor sure to confirm the work status ",style: TextStyle(fontSize: 21),),
                           ),
                           ListTile(
                             dense: true,
                             title: Text("Click ok to confirm",style: TextStyle(fontSize: 21),),
                           ),
                           ButtonTheme.bar(
                             child: ButtonBar(
                               children: <Widget>[
                                 FlatButton(
                                   child: const Text("OK",style: TextStyle(fontSize: 20),),
                                   onPressed: () async{

                                      var response = await http.post('http://10.0.2.2:9090/grievances/update.php',body:{
                                       "state": "0",
                                       "id": "${widget.gerven.id}",
                                     

                                     });
                                     print(response.body);
                                     Navigator.pop(context);
                                     Navigator.pop(context);
                                    }
                                    
                                   
                                 )
                               ],
                             ),
                           )
                         ],
                       ),
                     ),
                    
                   );

                 },
               )
             ].map((Widget button)=>Container(
               padding: EdgeInsets.symmetric(vertical: 8.0),
               child: button,
             )).toList(),
           )
                ]),
                
    ));
    
  }
}

