import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../customeWidgets/classifyFloatBtn.dart';

class SingleHerb extends StatefulWidget {
  @override
  _SingleHerbState createState() => new _SingleHerbState();
}

class _SingleHerbState extends State<SingleHerb> {
  @override
  Widget build(BuildContext context) {
    Uint8List finalImageBytes;
    if (finalImageBytes == null) {
      return new Scaffold(
          backgroundColor: Colors.grey,
          // appBar: new AppBar(
          //   title: new Text("多種中藥辨識"),
          //   backgroundColor: Colors.green[900],
          // ),
          body: new Center(child: new Text("MultiHerb2")),
          floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                child: Icon(
                  Icons.camera,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: FloatingActionButton(
                  child: Icon(
                    Icons.folder_open,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    print("Before finalImageBytes: " +
                        finalImageBytes.toString());

                    print(
                        "After finalImageBytes: " + finalImageBytes.toString());
                  },
                ),
              ),
            ],
          ));
    }
    return new Scaffold(
        backgroundColor: Colors.grey,
        // appBar: new AppBar(
        //   title: new Text("多種中藥辨識"),
        //   backgroundColor: Colors.green[900],
        // ),
        body: new Center(
            child: PhotoView(
          imageProvider: MemoryImage(finalImageBytes),
          backgroundDecoration: BoxDecoration(color: Colors.white),
        )),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(
                Icons.camera,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            FloatingActionButton(
              child: Icon(
                Icons.folder_open,
                color: Colors.white,
              ),
              onPressed: () {
                print("Before finalImageBytes: " + finalImageBytes.toString());

                print("After finalImageBytes: " + finalImageBytes.toString());
              },
            ),
          ],
        ));
  }
}
