import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:photo_view/photo_view.dart';

// import 'package:image_picker_saver/image_picker_saver.dart';

class MultiHerb2 extends StatefulWidget {
  @override
  _MultiHerb2State createState() => new _MultiHerb2State();
}

class _MultiHerb2State extends State<MultiHerb2> {
  Uint8List finalImageBytes;
  var resultlist;
  int resultlistCount;
  @override
  Widget build(BuildContext context) {
    if (finalImageBytes == null) {
      return new Scaffold(
          backgroundColor: Colors.grey[300],
          // appBar: new AppBar(
          //   title: new Text("多種中藥辨識"),
          //   backgroundColor: Colors.green[900],
          // ),
          body:
          //new Center(child: new Text("MultiHerb2")),
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
                      //"\n3. 請嘗試不同的角度"+
                      "\n",
                ),
              ),
            ),
          ),
          floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                onPressed: () {
                  _selectImageAndDectect(context, 1);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: FloatingActionButton(
                  child: Icon(
                    Icons.folder_open,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    print("Before finalImageBytes: " +
                        finalImageBytes.toString());
                    _selectImageAndDectect(context, 2);
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
        body: Column(
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
              ],
            )),
            Expanded(
              child: resultToListView(),
            ),
          ],
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              onPressed: () {
                _selectImageAndDectect(context, 1);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: FloatingActionButton(
                child: Icon(
                  Icons.folder_open,
                  color: Colors.white,
                ),
                onPressed: () {
                  print(
                      "Before finalImageBytes: " + finalImageBytes.toString());
                  _selectImageAndDectect(context, 2);
                  print("After finalImageBytes: " + finalImageBytes.toString());
                },
              ),
            ),
          ],
        ));
  }

  ListView resultToListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: resultlistCount,
      itemBuilder: (BuildContext context, int position) {
        Color tempColor = HexColor(resultlist[position]['color']);
        var tempId = resultlist[position]['id'];

        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(backgroundColor: tempColor),
            title: Text(
              tempId,
              style: titleStyle,
            ),
            subtitle: Text(tempId),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.grey, size: 30.0),
            onTap: () {
              debugPrint("ListTile Tapped");
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         DetailPage(herb: this.herbList[position]),
              //   ),
              // );
            },
          ),
        );
      },
    );
  }

  _selectImageAndDectect(BuildContext context, int src) async {
    Dio dio = new Dio();
    dio.options.baseUrl = "http://gpu39.cse.cuhk.edu.hk:5000";

    File image;
    if (src == 1) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else if (src == 2) {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    print("Original Image: " + image.toString());

    List<int> imageBytes = image.readAsBytesSync();

    print("image: " + imageBytes.toString());

    Response response;

    //Send response and wait for return
    response = await dio.post(
      "/object_detection",
      data: imageBytes,
      options: new Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded")),
    );
    // Map<String, dynamic> data = jsonDecode(response.data.toString());

    // debugPrint("Response:  ${data['image']}");
    // print("Response:  ${data['predictions']}");

    // List<int> reponseData = data['image'];
    // String returnImage = data['image'];
    var resJson = json.decode(response.data);

    String returnImage = resJson['image'];
    Uint8List _base64 = base64.decode(returnImage);

    print(resJson['predictions'].length);

    for (var pre in resJson['predictions']) {
      print(pre['id']);
      print(pre['color']);
    }

    setState(() {
      finalImageBytes = _base64;
      resultlist = resJson['predictions'];
      resultlistCount = resJson['predictions'].length;
      return finalImageBytes;
    });
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
