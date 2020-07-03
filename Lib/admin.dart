import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign/sign_in.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String name = '';
  String email = '';

  void initState() {
    start();
    super.initState();
  }

  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignOut(BuildContext context) async {
    await _googleSignIn.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
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
      appBar: AppBar(title: Text('REPORTS'), actions: <Widget>[
        IconButton(
            icon: new Icon(Icons.more_vert),
            onPressed: () {
              _showDialog();
            })
      ]),
      body: Center(
        child: Text("WELCOME "),
      ),
    );
  }

  void start() async {
    await _googleSignIn.signIn();
    setState(() {
      name = _googleSignIn.currentUser.displayName;
      email = _googleSignIn.currentUser.email;
    });
  }
}

