import 'package:flutter/material.dart';

import 'loginpage.dart';
import 'dashboard.dart';
import 'signuppage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new MyApp(),
        '/signup' : (BuildContext context) => new SignupPage(),
        '/homepage' : (BuildContext context) => DashboardPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Classified'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: new Center(
        child: LoginPage(),
      ),
    );
  }
}
