import 'package:flutter/material.dart';
import 'package:chineseherb_app/models/herb.dart';
import 'package:photo_view/photo_view.dart';
class DetailPage extends StatelessWidget {
  final Herb herb;

  DetailPage({Key key, @required this.herb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(herb.haveIcon);
    if(herb.haveIcon =='1'){

      String file_name = herb.herbID.toString();
      while(file_name.length < 4){
        file_name = "0"+file_name;
      }
      print(file_name);
      return new Scaffold(
        appBar: new AppBar(
          title: new Text(herb.chName),
          backgroundColor: Colors.blueGrey,
        ),
        body: new SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: new Row(
            children: [
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      height: 200.0,
                      child: ClipRect(
                        child: PhotoView(
                          imageProvider: AssetImage("assets/herbs_icon/" + file_name + ".jpg" ),
                          maxScale: PhotoViewComputedScale.covered * 2.0,
                          minScale: PhotoViewComputedScale.covered,
                          initialScale: PhotoViewComputedScale.covered,
                        ),
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: new Text(
                        herb.chName,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: new Text(
                        herb.engName,
                        style: new TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.all(8.0),
                      height: 1.5,
                      color: Colors.grey[300],
                    ),
                    new Container(
                      padding: const EdgeInsets.only(top: 8.0),
                      child:  new Text(
                        "性味",
                        style: new TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: new Text(
                        herb.taste,
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(top: 8.0),
                      child:  new Text(
                        "效用",
                        style: new TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: new Text(
                        herb.effect,
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(top: 8.0),
                      child:  new Text(
                        "性狀",
                        style: new TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: new Text(
                        herb.shape,
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(top: 8.0),
                      child:  new Text(
                        "品質",
                        style: new TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: new Text(
                        herb.qulity,
                      ),
                    ),
                  ] ,
                ),
              ),
            ],
          ),
        ),
      );
    } //if
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(herb.chName),
        backgroundColor: Colors.blueGrey,
      ),
      body: new SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: new Row(
          children: [
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      herb.chName,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      herb.engName,
                      style: new TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 1.5,
                    color: Colors.grey[300],
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child:  new Text(
                      "性味",
                      style: new TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      herb.taste,
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child:  new Text(
                      "效用",
                      style: new TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      herb.effect,
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child:  new Text(
                      "性狀",
                      style: new TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      herb.shape,
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child:  new Text(
                      "品質",
                      style: new TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      herb.qulity,
                    ),
                  ),
                ] ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
