import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:chineseherb_app/databaseHelper.dart';
import 'package:chineseherb_app/models/herb.dart';

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
              prefixIcon: Icon(Icons.search),
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

  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(backgroundColor: Colors.blueGrey),
            title: Text(
              this.herbList[position].chName,
              style: titleStyle,
            ),
            subtitle: Text(this.herbList[position].engName),
            onTap: () {
              debugPrint("ListTile Tapped");
            },
          ),
        );
      },
    );
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
