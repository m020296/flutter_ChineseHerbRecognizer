import 'dart:io';
import 'dart:typed_data';

import 'package:chineseherb_app/databaseHelper.dart';
import 'package:chineseherb_app/models/herb.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tflite/tflite.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:chineseherb_app/pages/DetailPage.dart';

class SingleHerb extends StatefulWidget {

  @override
  _SingleHerbState createState() => new _SingleHerbState();
}

class _SingleHerbState extends State<SingleHerb> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Herb> herbList;
  Uint8List finalImageBytes;
  int count = 0;
  @override
  String currentHerb = "Please take photo";
  bool confident = false;
  double confidence;
  double threshold = 0.5;
  Herb targetHerb;

  bool _saving = false;

  Widget build(BuildContext context) {
    if (finalImageBytes == null) {
      return new Scaffold(
          backgroundColor: Colors.grey[300],
          // appBar: new AppBar(
          //   title: new Text("多種中藥辨識"),
          //   backgroundColor: Colors.green[900],
          // ),
          body :ModalProgressHUD(child:
          //new Center(child: new Text("Single Herb")),
          Container(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                title: Text(
                  "\n提示",
                  style: Theme.of(context).textTheme.subhead,
                ),
                subtitle: Text(
                      "\n1. 請用把中藥放左純色 / 白色背景上"+
                      "\n2. 請在光亮環境下拍攝"+
                      // "\n3. 請嘗試不同的角度" +
                      "\n",
                ),
              ),
            ),
          ),
          inAsyncCall: _saving
          ),
          floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "cam",
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                onPressed: () {
                  _detectImagebyCamera(context, 1);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: FloatingActionButton(
                  heroTag: "file",
                  child: Icon(
                    Icons.folder_open,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    print("Before finalImageBytes: " +
                        finalImageBytes.toString());
                    _detectImagebyCamera(context, 2);
                    print(
                        "After finalImageBytes: " + finalImageBytes.toString());
                  },
                ),
              ),
            ],
          ));
    } else if (confident == false) {
      return new Scaffold(
          backgroundColor: Colors.grey[300],
          // appBar: new AppBar(
          //   title: new Text("多種中藥辨識"),
          //   backgroundColor: Colors.green[900],
          // ),
          body: ModalProgressHUD(child:Container(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                title: Text(
                  "未能辨識",
                  style: Theme.of(context).textTheme.subhead,
                ),
                subtitle: Text(
                  "\n請再嘗試!\n\n提示:\n 1. 請用把中藥放左純色背景上\n 2. 請在光亮環境下拍攝\n 3. 請嘗試不同的角度 \n ",
                ),
              ),
            ),
          ),
              inAsyncCall: _saving),
          floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "cam",
                child: Icon(
                  Icons.camera,
                  color: Colors.white,
                ),
                onPressed: () {
                  _detectImagebyCamera(context, 1);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: FloatingActionButton(
                  heroTag: "file",
                  child: Icon(
                    Icons.folder_open,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    print("Before finalImageBytes: " +
                        finalImageBytes.toString());
                    _detectImagebyCamera(context, 2);
                    print(
                        "After finalImageBytes: " + finalImageBytes.toString());
                  },
                ),
              ),
            ],
          ));
    }

    String file_name = targetHerb.herbID.toString();
    while(file_name.length < 4){
      file_name = "0"+file_name;
    }
    return new Scaffold(
        backgroundColor: Colors.grey[300],
        // appBar: new AppBar(
        //   title: new Text("多種中藥辨識"),
        //   backgroundColor: Colors.green[900],
        // ),
        body: ModalProgressHUD(child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: ListView(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  height: 200.0,
                  child: ClipRect(
                    child: PhotoView(
                      imageProvider: MemoryImage(finalImageBytes),
                      maxScale: PhotoViewComputedScale.covered * 2.0,
                      minScale: PhotoViewComputedScale.covered,
                      initialScale: PhotoViewComputedScale.covered,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "電腦分析上圖 " + (confidence * 100).toStringAsFixed(0) + "% 為",
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
                Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/herbs_icon/" + file_name + ".jpg"),
                        backgroundColor: Colors.blueGrey),
                    title: Text(
                      targetHerb.chName,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    subtitle: Text(targetHerb.engName),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.grey, size: 30.0),
                    onTap: () {
                      debugPrint("card Tapped");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(herb: targetHerb),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
          ],
        ),
            inAsyncCall: _saving),
        // body: PhotoView(
        //   imageProvider: MemoryImage(finalImageBytes),
        //   backgroundDecoration: BoxDecoration(color: Colors.white),
        // ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "cam",
              child: Icon(
                Icons.camera,
                color: Colors.white,
              ),
              onPressed: () {
                _detectImagebyCamera(context, 1);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: FloatingActionButton(
                heroTag: "file",
                child: Icon(
                  Icons.folder_open,
                  color: Colors.white,
                ),
                onPressed: () {
                  print(
                      "Before finalImageBytes: " + finalImageBytes.toString());
                  _detectImagebyCamera(context, 2);
                  print("After finalImageBytes: " + finalImageBytes.toString());
                },
              ),
            ),
          ],
        ));
  }

  _detectImagebyCamera(BuildContext context, int source) async {
    File image;
    if (source == 1) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else if (source == 2) {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    List<int> imageBytes = image.readAsBytesSync();

    setState(() {
      _saving = true;
    });

    String res = await Tflite.loadModel(
      model: "assets/output_graph.tflite",
      labels: "assets/output_labels.txt",
    );
    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 5, // defaults to 5
        threshold: 0.1 // defaults to 0.1
        );

    print(recognitions.toString());
    var first;
    for (var reg in recognitions) {
      print(reg.toString());
      first = reg;
      break;
    }

    print("Label: " + first["label"]);
    print("confidence: " + first["confidence"].toString());
    if (first["confidence"] > threshold) {
      final Future<Database> dbFuture = databaseHelper.database;
      dbFuture.then((database) {
        Future<List<Herb>> herbListFuture =
            databaseHelper.getHerbListbyID(first["label"]);
        herbListFuture.then((herbList) {
          setState(() {
            confident = true;
            confidence = first["confidence"];
            this.herbList = herbList;
            this.count = herbList.length;
            finalImageBytes = imageBytes;
            targetHerb = this.herbList[0];
            currentHerb = this.herbList[0].chName;
            _saving = false;
          });
        });
      });
    } else {
      setState(() {
        confident = false;
        finalImageBytes = imageBytes;
        _saving = false;
      });
    }

    // setState(() {
    //   finalImageBytes = imageBytes;
    //   currentHerb = this.herbList[0].chName;
    //   return finalImageBytes;
    // });
  }
}
