import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class DetectFBtn extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  DetectFBtn({this.onPressed, this.tooltip, this.icon});

  @override
  _DetectFBtnState createState() => _DetectFBtnState();
}

class _DetectFBtnState extends State<DetectFBtn>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red[900],
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        0.50,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget add() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn4",
        onPressed: () {
          print("Detect Pressed camera");
        },
        tooltip: 'Add',
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  Widget image() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn3",
        onPressed: () {
          print("Detect Pressed Select from Album");
          _selectImageAndDectect(context);
        },
        tooltip: 'Image',
        child: Icon(Icons.image),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn1",
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.search_ellipsis,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: add(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: image(),
        ),
        // Transform(
        //   transform: Matrix4.translationValues(
        //     0.0,
        //     _translateButton.value,
        //     0.0,
        //   ),
        //   child: inbox(),
        // ),
        toggle(),
      ],
    );
  }
}

_selectImageAndDectect(BuildContext context) async {
  Dio dio = new Dio();
  dio.options.baseUrl = "http://gpu31.cse.cuhk.edu.hk:5000";
  File image;
  image = await ImagePicker.pickImage(source: ImageSource.gallery);
  var bytes = image.readAsBytes();
  Response response;
  response = await dio.post(
    "/object_detection",
    data: bytes,
    options: new Options(
        contentType: ContentType.parse("application/x-www-form-urlencoded")),
  );

  print(response.data.toString());

  // setState(() {
  //   _processedData.add(results);
  //   if (adClickAcc > 1) {
  //     adClickAcc = 0;
  //   } else {
  //     adClickAcc += 1;
  //   }
  // });

  // if (adClickAcc > 1) {
  //   myInterstitial
  //     ..load()
  //     ..show();
  // }
}
