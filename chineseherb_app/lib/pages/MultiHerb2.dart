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
  @override
  Uint8List finalImageBytes;
  Widget build(BuildContext context) {
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
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                onPressed: () {},
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
                    _selectImageAndDectect(context);
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
                Icons.camera_alt,
                color: Colors.white,
              ),
              onPressed: () {},
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
                  _selectImageAndDectect(context);
                  print("After finalImageBytes: " + finalImageBytes.toString());
                },
              ),
            ),
          ],
        ));
  }

  _selectImageAndDectect(BuildContext context) async {
    Dio dio = new Dio();
    dio.options.baseUrl = "http://gpu38.cse.cuhk.edu.hk:5000";

    File image;
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
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

    print(resJson['predictions']);

    // var utf8Encoded = utf8.encode(returnImage);
    // var base64Encoded = base64.encode(utf8Encoded);
    // var finalImg = base64.decode(base64Encoded);
    // debugPrint("finalImg: " + finalImg.toString());
    // List<int> encodedImage = utf8.encode(returnImage);
    // Uint8List bytes = base64.decode(encodedImage);

    // List<int> encoded = Utf8Encoder
    // String decoded = base64.decode(encoded);
    // List<int> list = returnImage.codeUnits;
    // debugPrint("list: " + list.toString());
    // Uint8List bytes = Uint8List.fromList(list);
    // String string = String.fromCharCodes(bytes);

    // List<int> encoded = utf8.encode(returnImage);
    // debugPrint("encoded: " + encoded.toString());
    // String _base64 = base64Encode(encoded);

    // debugPrint("Base 64 Response: " + _base64.toString());
    // File responseImage = new File("/storage/emulated/0/Download/new.jpeg'")
    //   ..writeAsStringSync(reponseData);
    // String _base64 = base64.encode(data['image'].bodyBytes);
    // debugPrint("responseImage: " + _base64);
    // print("Response: " + response.data.toString());

    setState(() {
      finalImageBytes = _base64;
      return finalImageBytes;
    });
  }
}
