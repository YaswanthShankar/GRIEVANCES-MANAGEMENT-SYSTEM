import 'dart:convert';

import 'package:flutter/material.dart';
 import 'SecondScreen.dart';
import 'package:http/http.dart' as http;

import 'userscreen.dart';

class Bar extends StatefulWidget {
  @override
  _Bar createState() => _Bar();
}

class _Bar extends State<Bar> {
  String split;
  String split1;
  final numItems = 20;
  

  List<Gerven> g = [];

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      FutureBuilder<List<Gerven>>(
        future: downloadJSON(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Gerven> gerven = snapshot.data;
            return new CustomListView(gerven);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          //return  a circular progress indicator.
          return new CircularProgressIndicator();
        },
      ),
      Column(children: <Widget>[
        RaisedButton(
          color: Colors.green,
          child: Text("Select the Starting date",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
          onPressed: () async {
            DateTime dateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2050));
            if (dateTime != null) {
              setState(() {
                split = dateTime.toString().split(' ')[0];
              });
              
            }
          },
        ),
        Text("Selected date =$split",
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0)),
        RaisedButton(
          color: Colors.red,
          child: Text(
            "Select the last date",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          onPressed: () async {
            DateTime dateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2050));
            if (dateTime != null) {
              setState(() {
                split1 = dateTime.toString().split(' ')[0];
              });
            }
          },
        ),
        Text("Selected date =$split1",
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0)),
        RaisedButton(
            color: Colors.blue,
            child: Text("GENERATE REPORT"),
            onPressed: () async {
              var response = await http
                  .post('http://10.0.2.2:9090/grievances/records.php', body: {
                "Date_Time": split,
                "Date_Time1": split1,
              });
              print(response.body);

              List greven = json.decode(response.body);
              setState(() {
                g = greven
                    .map((greven) => new Gerven.fromJson(greven))
                    .toList();
              });
            }),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: g.map((f) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(f.name,style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0,color: Colors.deepOrange)),
                    onTap: () {
                      var route = MaterialPageRoute(
                        builder: (BuildContext context) =>
                            UserScreen(gerven: f),
                      );

                      Navigator.of(context).push(route);
                    },
                  ),
                  Divider()
                ],
              );
            }).toList(),
          ),
        ),
      ])
    ];
    final _kTabs = <Tab>[
      Tab(icon: Icon(Icons.cloud), text: 'RECENT PROBLEMS'),
      Tab(icon: Icon(Icons.alarm), text: 'PROBLEM'),
    ];
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('PROBLEM RECORDS'),
          backgroundColor: Colors.purple,
          bottom: TabBar(
            tabs: _kTabs,
          ),
        ),
        body: TabBarView(
          children: _kTabPages,
        ),
      ),
    );
  }
}
