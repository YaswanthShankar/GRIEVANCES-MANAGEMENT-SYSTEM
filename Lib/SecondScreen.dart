import 'dart:convert';
//import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:google_sign/third.dart';
import 'package:google_sign/monthrecords.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SecondScreen extends StatefulWidget {
  @override
  _SecondScreen createState() => _SecondScreen();
}

class _SecondScreen extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin Page'),
          actions: <Widget>[IconButton(icon: Icon(Icons.group_work),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>Month()));
          },)],
        ),
        body: FutureBuilder<List<Gerven>>(
          future: downloadJSON(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Gerven> gerven = snapshot.data;
              return new CustomListView(gerven);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return new CircularProgressIndicator();
          },
        ));
  }
}

class CustomListView extends StatelessWidget {
  final List<Gerven> gerven;
  CustomListView(this.gerven);
  Widget build(context) {
    return ListView.builder(
      itemCount: gerven.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(gerven[currentIndex], context);
      },
    );
  }

  Widget createViewItem(Gerven gerven, BuildContext context) {
    // Uint8List bytes = base64.decode(gerven.image);
    return ListTile(
        title: Card(
            elevation: 5.0,
            child: new Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.orange)),
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              child: Row(children: <Widget>[
                Icon(Icons.person),
                Column(
                  children: <Widget>[
                    Text(
                      "${gerven.name}",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                )
              ]),
            )),
        onTap: () async {
          var route = new MaterialPageRoute(
            builder: (BuildContext context) => new ThirdScreen(gerven: gerven),
          );
          Navigator.of(context).push(route);
        });
  }
}

class Gerven {
  final String name, image, description;
  final String date, id;
  Gerven({this.name, this.description, this.image, this.date, this.id});
  factory Gerven.fromJson(Map<String, dynamic> jsonData) {
    return Gerven(
      name: jsonData['name'],
      image: jsonData['Pics'],
      description: jsonData['Description'],
      date: jsonData['Date_Time'],
      id: jsonData['id'],
    );
  }
}
Future<List<Gerven>> downloadJSON() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String token = prefs.getString('token');
  final jsonEndpoint = "http://10.0.2.2:9090/grievances/fetch.php?token=$token";
  final response = await get(jsonEndpoint);
  if (response.statusCode == 200) {
    print(response.body);
    Map<String,dynamic> res = json.decode(response.body);
    List greven = res['greven'];
    return greven.map((greven) => new Gerven.fromJson(greven)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}
