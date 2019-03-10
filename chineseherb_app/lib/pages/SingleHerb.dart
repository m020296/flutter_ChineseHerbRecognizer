import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tflite/tflite.dart';

class SingleHerb extends StatefulWidget {
  @override
  _SingleHerbState createState() => new _SingleHerbState();
}

class _SingleHerbState extends State<SingleHerb> {
  @override
  Uint8List finalImageBytes;
  String currentHerb = "Please take photo";
  Widget build(BuildContext context) {
    if (finalImageBytes == null) {
      return new Scaffold(
          backgroundColor: Colors.grey[300],
          // appBar: new AppBar(
          //   title: new Text("多種中藥辨識"),
          //   backgroundColor: Colors.green[900],
          // ),
          body: new Center(child: new Text("Single Herb")),
          floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                child: Icon(
                  Icons.camera,
                  color: Colors.white,
                ),
                onPressed: () {
                  _detectImagebyCamera(context);
                },
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
              onPressed: () {
                _detectImagebyCamera(context);
              },
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

  _detectImagebyCamera(BuildContext context) async {
    File image;
    image = await ImagePicker.pickImage(source: ImageSource.camera);

    List<int> imageBytes = image.readAsBytesSync();

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

    setState(() {
      finalImageBytes = imageBytes;
      return finalImageBytes;
    });
  }
}
