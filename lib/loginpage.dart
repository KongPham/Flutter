import 'package:flutter/material.dart';

//Firebase auth
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: 'Enter your username'),
              onChanged: (value) {
                _email= value;
              },
            ),
            SizedBox(height: 15.0),
            TextField(
              decoration: InputDecoration(hintText: 'Enter your password'),
              onChanged: (value) {
               _password = value;
              },
              obscureText: true,
            ),
            SizedBox(height: 15.0),
            RaisedButton(
              onPressed: () {
                FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _email, password: _password)
                    .then((signedInUser) {
                      Navigator.of(context).pushReplacementNamed('/homepage');
                    }).catchError((e) {
                      print(e);
                    });
                },
              child: Text('Login'),
              color: Colors.blue,
              textColor: Colors.white,
              elevation: 7.0,
            ),
            SizedBox(height: 15.0),
            RaisedButton(
              onPressed: (){
                Navigator.of(context).pushNamed('/signup');
              },
              child: Text('SignUp'),
              color: Colors.blue,
              textColor: Colors.white,
              elevation: 7.0,
            )
          ],
        )
    );
  }
}