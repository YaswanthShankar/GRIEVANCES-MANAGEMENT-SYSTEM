import 'package:flutter/material.dart';
import 'package:google_sign/appbar.dart';
import 'package:google_sign/fancy-background.dart';
import 'package:google_sign/status_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign/sign_in.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  final bool admin;
  UserPage({this.admin});
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String name = '';
  String email = '';
  void initState() {
    start();
    super.initState();
  }

  final textEdit = TextEditingController();
  final numEdit = TextEditingController();
  final emailEdit = TextEditingController();
  final descedit = TextEditingController();
  File _image;
  int count = 0;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      count++;
    });
  }

  DateTime _date = DateTime.now();
  static const menuItems = <String>[
    'Electrical',
    'Carpendary',
    'Construction',
    'Plubming'
  ];

  final List<DropdownMenuItem<int>> _dropDownMenuItems = [
    DropdownMenuItem<int>(
      value: 1,
      child: Text('Electrical'),
    ),
    DropdownMenuItem<int>(
      value: 2,
      child: Text('Carpentry'),
    ),
    DropdownMenuItem<int>(
      value: 3,
      child: Text('Construction'),
    ),
    DropdownMenuItem<int>(
      value: 4,
      child: Text('Plumbing'),
    ),
  ];
  int _buttonSelected;
  String _validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required.';
    }
    final RegExp nameExp = new RegExp(r'^[A-Za-z]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter only Alphabetic letters';
    }
    return null;
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is requried.';
    }
    final RegExp emailexp =
        new RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailexp.hasMatch(value)) {
      return 'please enter the correct Email address ';
    }
    return null;
  }

  GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<void> _handleSignOut(BuildContext context) async {
    await _googleSignIn.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => FancyBackgroundApp(SignInPage())),
        (Route<dynamic> route) => false);
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blue[50],
            title: new Text(
              'Accounts',
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: ListBody(children: <Widget>[
                ListTile(
                    leading: new CircleAvatar(
                        child: Text(
                      name.substring(0, 1),
                    )),
                    title: Text(
                      name.split(' ')[0] ?? 'no user',
                    ),
                    subtitle: Text(email),
                    trailing: IconButton(
                      icon: Icon(Icons.power_settings_new),
                      onPressed: () => _handleSignOut(context),
                    )),
              ]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GRIEVANCES'), actions: <Widget>[
        widget.admin
            ? IconButton(
                icon: new Icon(Icons.work),
                tooltip: "Updated Problems",
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Bar()));
                })
            : new Container(),
        IconButton(
          icon: Icon(Icons.gavel),
          tooltip: "Work Status",
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Status()));
          },
        ),
        IconButton(
            icon: new Icon(Icons.assignment_ind),
            tooltip: "Account",
            onPressed: () {
              _showDialog();
            }),
      ]),
      body: new SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 12.0),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'Name',
                icon: Icon(Icons.person),
                hintText: 'Fill the requried field',
                filled: true,
              ),
              //  keyboardType: TextInputType.text,
              validator: _validateName,
              controller: textEdit,
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'PhoneNumber',
                icon: Icon(Icons.phone),
                hintText: 'Fill the phonenumber',
                filled: true,
                errorText: null,
                prefixText: '+91',
              ),
              keyboardType: TextInputType.phone,
              controller: numEdit,
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                  filled: true,
                  icon: Icon(Icons.email),
                  labelText: "Email",
                  hintText: " Please enter the email"),
              keyboardType: TextInputType.text,
              controller: emailEdit,
              validator: _validateEmail,
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.label_important),
              title: Text('Select the requried catageory',
                  style: TextStyle(fontSize: 20.0)),
              trailing: DropdownButton(
                hint: Text('Select department'),
                value: _buttonSelected,
                onChanged: ((value) {
                  setState(() {
                    _buttonSelected = value;
                  });
                }),
                items: this._dropDownMenuItems,
              ),
            ),
            Row(
              children: <Widget>[
                Icon(Icons.insert_invitation),
                Text(
                  "Select date:${_date.toString()}",
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            Row(
              children: <Widget>[],
            ),
            SizedBox(height: 26),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                icon: Icon(Icons.gavel),
                border: OutlineInputBorder(),
                hintText: "Please enter the Problems",
                labelText: "Description",
              ),
              maxLines: 3,
              keyboardType: TextInputType.text,
              controller: descedit,
            ),
            _image == null
                ? new Text('Please click the below button to capture image',
                    style: TextStyle(fontSize: 20.0))
                : new Image.file(_image),
            RaisedButton(
              onPressed: getImage,
              child: new Icon(Icons.camera),
            ),
            FlatButton(
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.green,
                onPressed: () async {
                  List<int> imageBytes = _image.readAsBytesSync();

                  String base64Image = base64Encode(imageBytes);
                  var response = await http.post(
                      'http://10.0.2.2:9090/grievances/insert.php',
                      body: {
                        "name": textEdit.text,
                        "phonenumber": numEdit.text,
                        "email": emailEdit.text,
                        "catageory": _buttonSelected.toString(),
                        "Description": descedit.text,
                        "Pics": base64Image,
                        "Date": _date.toString(),
                      });
                  print(response.body);
                  Map<String, dynamic> res = jsonDecode(response.body);
                  if (res['result'] == 'success') {
                    showToast("Your Response has be Submitted Successfully",
                        duration: Toast.LENGTH_LONG);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => UserPage(
                                  admin: widget.admin,
                                )));
                  } else {
                    showToast(res['result'], duration: Toast.LENGTH_LONG);
                  }
                }),
          ],
        ),
      ),
    );
  }

  void start() async {
    await _googleSignIn.signIn();
    setState(() {
      name = _googleSignIn.currentUser.displayName;
      email = _googleSignIn.currentUser.email;
      print('name');
    });
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}
