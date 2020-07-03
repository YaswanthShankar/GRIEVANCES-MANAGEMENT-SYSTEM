import 'package:flutter/material.dart';
import 'package:google_sign/fancy-background.dart';
import 'package:google_sign/sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grievances',
      
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: FancyBackgroundApp(SignInPage())
      
        
    );
  }
}