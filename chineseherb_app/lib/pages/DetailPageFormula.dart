import 'package:flutter/material.dart';
import 'package:chineseherb_app/models/formula.dart';
import 'package:chineseherb_app/databaseHelper.dart';
import 'package:chineseherb_app/models/herb.dart';
import 'package:chineseherb_app/pages/DetailPage.dart';
import 'package:sqflite/sqflite.dart';

class DetailPageFormula extends StatefulWidget {
  final Formula formula;
  DetailPageFormula({Key key, @required this.formula}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DetailPageFormulaState();
  }
}

class DetailPageFormulaState extends State<DetailPageFormula> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Herb> herbList;
  int herbCount = 0;
  GlobalKey _keyCard = GlobalKey();

  @override
  Widget build(BuildContext context) {

    if (herbList == null) {
      herbList = List<Herb>();
      getHerbs();
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.formula.chinese_name),
        backgroundColor: Colors.blueGrey,
      ),
      body: new SingleChildScrollView(
        //new SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      widget.formula.chinese_name,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      widget.formula.english_name,
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
                      "功用",
                      style: new TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      widget.formula.action,
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child:  new Text(
                      "主治",
                      style: new TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      widget.formula.indication,
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child:  new Text(
                      "組成",
                      style: new TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      widget.formula.combination,
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child:  new Text(
                      "出處",
                      style: new TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      widget.formula.source,
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child:  new Text(
                      "中藥材資料",
                      style: new TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  new Container(
//                    height: 65.0 * this.herbCount,
                    height: 64.0  * this.herbCount,
                    child: getNoteListView(),
                  ),
                ] ,
        ),
      ),
    );
  }

  double _getSizes() {
    double h = 0;
    try{
      RenderBox renderBoxRed = _keyCard.currentContext.findRenderObject();
      h = renderBoxRed.size.height;
    }catch(e){

    }
    print("height of Card: $h");
    return h;
  }

  String idToFileName(int id){
    String file_name = id.toString();
    while(file_name.length < 4){
      file_name = "0"+file_name;
    }
    return file_name;
  }

  void getHerbs() {
    final Future<Database> dbFuture = databaseHelper.database;
    dbFuture.then((database) {
      Future<List<Herb>> herbListFuture =
      databaseHelper.getHerbListbyFormula(widget.formula.formula_id);
      herbListFuture.then((herbList) {
        setState(() {
          this.herbList = herbList;
          this.herbCount = herbList.length;
        });
      });
    });
  }

  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    print("herbCount: " +herbCount.toString());
    for (Herb herb in this.herbList){
      print(herb.chName);
    }
    return ListView.builder(
      shrinkWrap: true,
      key: _keyCard,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: herbCount,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
                backgroundImage: AssetImage("assets/herbs_icon/" + idToFileName(this.herbList[position].herbID) + ".jpg"),
                backgroundColor: Colors.blueGrey),
            title: Text(
              this.herbList[position].chName,
              style: titleStyle,
            ),
//            subtitle: Text(this.herbList[position].engName),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.grey, size: 30.0),
            onTap: () {
              debugPrint("ListTile Tapped");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailPage(herb: this.herbList[position]),
                ),
              );
            },
          ),
        );
      },
    );
  }


}
