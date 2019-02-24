import 'package:flutter/material.dart';
import '../customeWidgets/classifyFloatBtn.dart';

class SingleHerb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // appBar: new AppBar(
        //   title: new Text("個別中藥辨識"),
        //   backgroundColor: Colors.green[900],
        // ),
        body: new Center(
          child: new Text("個別中藥辨識"),
        ),
        floatingActionButton: ClassifyFBtn());
  }
}
