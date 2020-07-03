import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign/user.dart';
// import 'package:sign_in/admin.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


 

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var res;
  String temp;
  

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
  ], hostedDomain: "bitsathy.ac.in");
  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      if (account != null) {
        verify(account);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('SIGN IN'),
        ),
        body: 
        Row(
         mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          
            IconButton(
              alignment: Alignment.center,
            
              icon: Icon(
                
                Icons.account_circle,
                color: Colors.green,
                // size: 70.0,
              ),
              onPressed: () async {
                await _googleSignIn.signOut();
                await _googleSignIn.signIn();
               
              },
            ),
          ],
        ));
  }

  void verify(GoogleSignInAccount account) async {
    GoogleSignInAuthentication user = await account.authentication;
    String token = user.accessToken;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    token = prefs.getString('token');
    print(token);
    var response = await http
        .get("http://10.0.2.2:9090/grievances/verify.php?token=$token");
    print(response.body);

    res = json.decode(response.body);
    _redirectuser();
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blue[50],
            title: new Text(
              'Sorry...',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            content: SingleChildScrollView(
              child: new Text(
                'You are not an authorized user...',
              ),
            ),
          );
        });
  }

  void _redirectuser() {
    if (res['user'] == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserPage(admin: res['admin'])));
    } else {
      _showDialog();
    }
  }

 

  // void _redirectadmin() {

  //   if (res['admin'] == true) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => AdminPage()));
  //   } else {
  //     _showDialog();
  //   }
  // }
}
