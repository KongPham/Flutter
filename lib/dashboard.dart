import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/crud.dart';


class DashboardPage extends StatefulWidget{
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>{
  String ads;
  String price;

  QuerySnapshot items;

  crudMedthods crudObj = new crudMedthods();

  Future<bool> addDialog(BuildContext context) async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Add Data', style: TextStyle(fontSize: 15.0)),
          content: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: 'What are you selling?'),
                onChanged: (value){
                  this.ads = value;
                },
              ),
              SizedBox(height: 5.0),
              TextField(
                decoration: InputDecoration(hintText: 'Enter your price'),
                onChanged: (value){
                  this.price = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Add'), textColor: Colors.blue,
              onPressed: (){
                Navigator.of(context).pop();
                crudObj.addData({
                  'ads': this.ads,
                  'price': this.price
                }).then((result){
                  dialogTrigger(context);
                }).catchError((e){
                  print(e);
                });
              },
            )
          ],
        );
      }
    );
  }

  Future<bool> dialogTrigger(BuildContext context) async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Job Done', style: TextStyle(fontSize: 15.0)),
          content: Text('Added'),
          actions: <Widget>[
            FlatButton(
              child: Text('Alright'),
              textColor: Colors.blue,
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  @override
  void initState() {
    crudObj.getData().then((results){
      setState(() {
        items = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Dashboard'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              crudObj.getData().then((results){
                setState(() {
                  items = results;
                });
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              addDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              Navigator.of(context).pushReplacementNamed('/login');
            },
          )
        ],
      ),
      body: _itemsList()
    );
  }

  Widget _itemsList(){
    if(items != null){
      return ListView.builder(
        itemCount: items.documents.length,
        padding: EdgeInsets.all(5.0),
        itemBuilder: (context, i){
          final data = items.documents[i].data;
          return new FlatButton(
              onPressed: null,
              child: new ItemCell(data),
          );
        },
      );
    }
  }

}

class ItemCell extends StatelessWidget{
  final data;
  ItemCell(this.data);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(16.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //new Image.network(data['imageUrl']),
              new Container(
                height: 8.0,
              ),
              Text(data['ads'], style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black)
              ),
              Text('Price: ' + data['price'], style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
        new Divider()
      ],
    );
  }

}
