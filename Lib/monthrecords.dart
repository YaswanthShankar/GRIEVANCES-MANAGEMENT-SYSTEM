import 'package:flutter/material.dart';
import 'package:google_sign/SecondScreen.dart';
class Month extends StatefulWidget{
  @override
 _MonthReport createState() => _MonthReport();
 }
 
 class _MonthReport extends State<Month> {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title:Text("MONTHLY RECORDS")),
      body: FutureBuilder<List<Gerven>>(
          future: downloadJSON(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Gerven> gerven = snapshot.data;
              return new CustomListView2(gerven);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            //return  a circular progress indicator.
            return new CircularProgressIndicator();
          },
        ),
    );
  }
  


}
class CustomListView2 extends StatelessWidget {

  final List<Gerven> gerven;

  CustomListView2(this.gerven);

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
                  BoxDecoration(border: Border.all(color: Colors.blue)),
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              child: Row(children: <Widget>[
                Icon(Icons.hdr_strong),
                Column(
                  children: <Widget>[
                   
                    Text(
                      "Date and time :${gerven.date}",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                )
              ]),
            )),
        );
  }
}

// class Gerven {
//   final String name, image, description;
//   final String date, id;

//   Gerven({this.name, this.description, this.image, this.date, this.id});

//   factory Gerven.fromJson(Map<String, dynamic> jsonData) {
//     return Gerven(
//       name: jsonData['name'],
//       image: jsonData['Pics'],
//       description: jsonData['Description'],
//       date: jsonData['Date'],
//       id: jsonData['id'],
//     );
//   }
// }
