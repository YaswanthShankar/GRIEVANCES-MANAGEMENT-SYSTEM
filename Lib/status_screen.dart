import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SecondScreen.dart';
import 'userscreen.dart';
 class Status extends StatefulWidget{
  @override
  _Status createState() => _Status();
 }
 class _Status extends State<Status>{
  @override
  Widget build(BuildContext context) {
   
    return new Scaffold(
      appBar: AppBar(title: Text("Work Status"),),
      body: FutureBuilder<List<Gerven>>(
          future: downloadJSON(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Gerven> gerven = snapshot.data;
              return new CustomListView1(gerven);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            //return  a circular progress indicator.
            return Center(child: new CircularProgressIndicator());
          },
        ),
    );
  }

 }
 class CustomListView1 extends StatelessWidget {
  final List<Gerven> gerven;
  CustomListView1(this.gerven);
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
    title:Card(    
      elevation: 5.0,
      child: new Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
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

       
      )
      ),
       onTap: () async{
            var route =  MaterialPageRoute(
            builder: (BuildContext context) =>
             UserScreen
            (gerven:gerven),
          );

          Navigator.of(context).push(route);
        });
}

}
Future<List<Gerven>> downloadJSON() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String token = prefs.getString('token');
  final jsonEndpoint = "http://10.0.2.2:9090/grievances/status.php?token=$token";
  final response = await get(jsonEndpoint);
  if (response.statusCode == 200) {
    print(response.body);
    Map<String,dynamic> res = json.decode(response.body);
    List greven = res['greven'];
    return greven.map((greven) => new Gerven.fromJson(greven)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}
