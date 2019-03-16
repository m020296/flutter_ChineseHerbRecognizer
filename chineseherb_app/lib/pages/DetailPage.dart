import 'package:flutter/material.dart';
import 'package:chineseherb_app/models/herb.dart';
class DetailPage extends StatelessWidget {
  final Herb herb;

  DetailPage({Key key, @required this.herb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
