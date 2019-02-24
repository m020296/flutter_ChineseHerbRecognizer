import 'package:flutter/material.dart';

import './SingleHerb.dart';
import './MultiHerb.dart';
import './MultiHerb2.dart';
import './Search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  _changeHeading(int index) {
    switch (index) {
      case 1:
        {
          return new Text("個別中藥辨識");
        }
        break;

      case 2:
        {
          return new Text("多種中藥辨識");
        }
        break;

      case 3:
        {
          return new Text("中藥／藥方搜尋");
        }
        break;

      default:
        {
          return new Text("中藥辨識");
        }
    }
  }

  _changePage(int index) {
    switch (index) {
      case 1:
        {
          return new SingleHerb();
        }
        break;

      case 2:
        {
          return new MultiHerb2();
        }
        break;

      case 3:
        {
          return new Search();
        }
        break;

      default:
        {
          return new Scaffold(
            body: new Center(
                child: new Text(
              "Chinese Herb Recognizer\n\nHomePage",
              style: new TextStyle(fontSize: 35.0),
              textAlign: TextAlign.center,
            )),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                if (!_key.currentState.isDrawerOpen) {
                  _key.currentState.openDrawer();
                } else {
                  Navigator.of(context).pop();
                }
              }),
          title: _changeHeading(pageIndex),
          backgroundColor: Colors.green[900],
          automaticallyImplyLeading: false,
        ),
        body: Scaffold(
            key: _key,
            drawer: SizedBox(
              width: 250.0,
              child: new Drawer(
                child: new ListView(
                  // padding: const EdgeInsets.symmetric(vertical: 70.0),
                  children: <Widget>[
                    new Container(
                      height: 56.0,
                      color: Colors.lightGreen[50],
                      child: DrawerHeader(
                          child: InkWell(
                              child: Text("主頁",
                                  style: new TextStyle(
                                      fontSize: 30, color: Colors.black),
                                  textAlign: TextAlign.center),
                              onTap: () {
                                Navigator.of(context).pop();
                                setState(() => pageIndex = 0);
                              }),
                          margin: EdgeInsets.all(0.0),
                          padding: EdgeInsets.all(10.0)),
                    ),
                    new ListTile(
                        title: new Text("個別中藥辨識"),
                        leading: new Icon(Icons.all_out),
                        onTap: () {
                          // return new SingleHerb();
                          Navigator.of(context).pop();
                          // _testChange(1);
                          setState(() => pageIndex = 1);
                          // Navigator.of(context).push(new MaterialPageRoute(
                          //     builder: (BuildContext context) => new SingleHerb()));
                          // Navigator.pushReplacementNamed(context, "/singleherb");
                        }),
                    new ListTile(
                        title: new Text("多種中藥辨識"),
                        leading: new Icon(Icons.category),
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() => pageIndex = 2);
                        }),
                    new ListTile(
                        title: new Text("中藥／藥方搜尋"),
                        leading: new Icon(Icons.search),
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() => pageIndex = 3);
                        }),
                  ],
                ),
              ),
            ),
            body: _changePage(pageIndex)));
  }
}
