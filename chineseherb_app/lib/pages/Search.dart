import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:chineseherb_app/databaseHelper.dart';
import 'package:chineseherb_app/models/herb.dart';
import 'package:chineseherb_app/pages/DetailPage.dart';

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchListState();
  }
}

class SearchListState extends State<Search> {
  TextEditingController editingController = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Herb> herbList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (herbList == null) {
      herbList = List<Herb>();
      updateListView();
    }
    TextEditingController editingController = TextEditingController();
    String currentInput = "";
    // return new Scaffold(
    // appBar: new AppBar(
    //   title: new Text("中藥／藥方搜尋"),
    //   backgroundColor: Colors.green[900],
    // ),
    return Container(
        child: Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          onChanged: (value) {
            currentInput = value;
            // filterSearchResults(value);
          },
          controller: editingController,
          decoration: InputDecoration(
              labelText: "Search",
              hintText: "Search",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    print("Current input: " + currentInput);
                    filterSearchResults(currentInput);
                  })),
        ),
      ),
      Expanded(
        child: getNoteListView(),
      ),
    ]));
  }

  String idToFileName(int id){
    String file_name = id.toString();
    if(file_name.length == 1){
      file_name = "000"+file_name;
    }else if(file_name.length == 2){
      file_name = "00"+file_name;
    }else if(file_name.length == 3){
      file_name = "0"+file_name;
    }
    return file_name;
  }


  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

//    try{
      return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/herbs_icon/" + idToFileName(this.herbList[position].herbID) + ".jpg"),
                  backgroundColor: Colors.brown[50]),
              title: Text(
                this.herbList[position].chName,
                style: titleStyle,
              ),
              subtitle: Text(this.herbList[position].engName),
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
//    }catch(e){
//      return ListView.builder(
//        itemCount: count,
//        itemBuilder: (BuildContext context, int position) {
//          return Card(
//            color: Colors.white,
//            elevation: 2.0,
//            child: ListTile(
//              leading: CircleAvatar(
//                  backgroundColor: Colors.blueGrey),
//              title: Text(
//                this.herbList[position].chName,
//                style: titleStyle,
//              ),
//              subtitle: Text(this.herbList[position].engName),
//              trailing: Icon(Icons.keyboard_arrow_right,
//                  color: Colors.grey, size: 30.0),
//              onTap: () {
//                debugPrint("ListTile Tapped");
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) =>
//                        DetailPage(herb: this.herbList[position]),
//                  ),
//                );
//              },
//            ),
//          );
//        },
//      );
//    }

  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Herb>> herbListFuture = databaseHelper.getHerbList();
      herbListFuture.then((herbList) {
        setState(() {
          this.herbList = herbList;
          this.count = herbList.length;
        });
      });
    });
  }

  void filterSearchResults(value) {
    print(value);
    final Future<Database> dbFuture = databaseHelper.database;
    dbFuture.then((database) {
      Future<List<Herb>> herbListFuture =
          databaseHelper.getHerbListbyValue(value);
      herbListFuture.then((herbList) {
        setState(() {
          this.herbList = herbList;
          this.count = herbList.length;
        });
      });
    });
  }
}
