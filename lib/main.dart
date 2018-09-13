import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './views/cell.dart';
import './views/detailPage.dart';

void main() => runApp(new ClassifiedApp());

class ClassifiedApp extends StatefulWidget{
  @override
    State<StatefulWidget> createState(){
      return new ClassifiedState();
  }
}

class ClassifiedState extends State<ClassifiedApp>{
  var _isLoading = true;

  var videos;

  _fetchData() async {
    print("Attempting to fetch data from the network");

    final url = "https://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(url);

    if(response.statusCode == 200){
      //print(response.body);

      final map = json.decode(response.body);
      final videosJson = map["videos"];

      //videosJson.forEach((video){
      //  print(video["name"]);
      //});

      setState(() {
        _isLoading = false;
        this.videos = videosJson;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
          appBar:  new AppBar(
            title: new Text("CLASSIFIED"),
            actions: <Widget>[
              new IconButton(icon: new Icon(Icons.refresh), onPressed: (){
                print("Reloading...");
                setState(() {
                  _isLoading = true;
                });
                _fetchData();
              })
            ]
          ),
          body: new Center(
            child: _isLoading ? new CircularProgressIndicator():
                new ListView.builder(
                  itemCount: this.videos != null ? this.videos.length : 0,
                  itemBuilder: (context, i){
                    final video = this.videos[i];
                    return new FlatButton(
                      padding: new EdgeInsets.all(0.0),
                      child: new VideoCell(video),
                      onPressed: (){
                        print("Video cell tapped: $i");
                        Navigator.push(context,
                            new MaterialPageRoute(
                                builder: (context)=> new DetailPage(video)
                            )
                        );
                      },
                    );
                  },
                ),
          ),
        )
    );
  }
}

