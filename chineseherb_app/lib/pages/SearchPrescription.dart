import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:chineseherb_app/databaseHelper.dart';
import 'package:chineseherb_app/models/formula.dart';
import 'package:chineseherb_app/pages/DetailPageFormula.dart';

class SearchPrescription extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchListState();
  }
}

class SearchListState extends State<SearchPrescription> {
  TextEditingController editingController = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Formula> formulaList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (formulaList == null) {
      formulaList = List<Formula>();
      updateListView();
    }
    TextEditingController editingController = TextEditingController();
    String currentInput = "";
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
                  backgroundColor: Colors.blueGrey),
              title: Text(
                this.formulaList[position].chinese_name,
                style: titleStyle,
              ),
              subtitle: Text(this.formulaList[position].english_name),
              trailing: Icon(Icons.keyboard_arrow_right,
                  color: Colors.grey, size: 30.0),
              onTap: () {
                debugPrint("ListTile Tapped");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailPageFormula(formula: this.formulaList[position]),
                  ),
                );
              },
            ),
          );
        },
      );
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.database;
    dbFuture.then((database) {
      Future<List<Formula>> formulaListFuture = databaseHelper.getFormulaList();
      formulaListFuture.then((formulaList) {
        setState(() {
          this.formulaList = formulaList;
          this.count = formulaList.length;
        });
      });
    });
  }

  void filterSearchResults(value) {
    print(value);
    final Future<Database> dbFuture = databaseHelper.database;
    dbFuture.then((database) {
      Future<List<Formula>> formulaListFuture =
          databaseHelper.getFormulaListbyValue(value);
      formulaListFuture.then((formulabList) {
        setState(() {
          this.formulaList = formulabList;
          this.count = formulabList.length;
        });
      });
    });
  }
}
