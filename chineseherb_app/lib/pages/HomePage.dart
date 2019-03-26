import 'package:flutter/material.dart';

import './SingleHerb.dart';
import './MultiHerb2.dart';
import './Search.dart';
import './SearchPrescription.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  _changeHeading(int index) {
    switch (index) {
      case 1:
        {
          return new Text("個別中藥材辨識");
        }
        break;

      case 2:
        {
          return new Text("多種中藥材辨識");
        }
        break;

      case 3:
        {
          return new Text("中藥材搜尋");
        }
        break;

      case 4:
        {
          return new Text("中藥方劑搜尋");
        }
        break;

      default:
        {
          return new Text("中藥材辨識");
        }
    }
  }

  _changePage(int index) {
    switch (index) {
      case 1:
        {
          return new SingleHerb();
        }
        break;

      case 2:
        {
          return new MultiHerb2();
        }
        break;

      case 3:
        {
          return new Search();
        }
        break;

      case 4:
        {
          return new SearchPrescription();
        }
        break;

      default:
        {
          return new Scaffold(
            backgroundColor: Colors.grey[300],
//            body:
            body: Container(
              padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                child: ListTile(
                  title: Text(
                    "\n免責條款",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  subtitle: Text(
                    "\n人工智能的計算結果未必百分百準確，且非中藥材專家，系統作者亦沒有得到任何關於中醫學、中藥材的專業資格。故本系統所提供的資料只供參考之用。系統作者對於所提供的資料，並沒有作出任何準確性或恰當性的保證或擔保。"+
                    "\n\n本系統亦載有由其他人士或機構所提供的資料，而系統作者對該等資料並無影響力。對於本系統有關連的任何因由所引致的任何損失或損害，系統作者概不負責。"+
                    "\n\n使用者須負責自行評估本系統所載的各項資料，並應在根據該等資料行事前，徵詢其他獨立、專業的中醫學、中藥材專家意見。"+
                    "\n\n系統作者不會對使用或任何人士使用本應用程式而引致任何直接、間接損害承擔任何賠償及負上法律責任。"+
                    "\n",
                  ),
                ),
              ),
            ),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _key,
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                if (!_key.currentState.isDrawerOpen) {
                  _key.currentState.openDrawer();
                } else {
                  Navigator.of(context).pop();
                }
              }),
          title: _changeHeading(pageIndex),
          backgroundColor: Colors.brown[300],
          automaticallyImplyLeading: false,
        ),
        drawer: SizedBox(
          width: 250.0,
          child: new Drawer(
            child: new ListView(
              // padding: const EdgeInsets.symmetric(vertical: 70.0),
              children: <Widget>[
                    DrawerHeader(
                      padding: EdgeInsets.zero,
                      child: new Stack(children: <Widget>[
                        new Image.asset(
                        'assets/header.jpg', fit: BoxFit.fill, width: double.infinity,),
                        new Align(
                          alignment: FractionalOffset.bottomLeft,
                          child: new Container(
                            margin: EdgeInsets.all(15.0),
                            child: new Text(
                            "中藥材辨識",
                              style: new TextStyle(
                                  color: Colors.brown[600],
                                  fontWeight: FontWeight.bold,
//                                  fontSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                      ],),
                    ),
                new ListTile(
                    title: new Text("主頁"),
                    leading: new Icon(Icons.home),
                    onTap: () {
                      // return new SingleHerb();
                      Navigator.of(context).pop();
                      // _testChange(1);
                      setState(() => pageIndex = 0);
                      // Navigator.of(context).push(new MaterialPageRoute(
                      //     builder: (BuildContext context) => new SingleHerb()));
                      // Navigator.pushReplacementNamed(context, "/singleherb");
                    }),
                new ListTile(
                    title: new Text("個別中藥材辨識"),
                    leading: new Icon(Icons.all_out),
                    onTap: () {
                      // return new SingleHerb();
                      Navigator.of(context).pop();
                      // _testChange(1);
                      setState(() => pageIndex = 1);
                      // Navigator.of(context).push(new MaterialPageRoute(
                      //     builder: (BuildContext context) => new SingleHerb()));
                      // Navigator.pushReplacementNamed(context, "/singleherb");
                    }),
                new ListTile(
                    title: new Text("多種中藥材辨識"),
                    leading: new Icon(Icons.category),
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() => pageIndex = 2);
                    }),
                new ListTile(
                    title: new Text("中藥材搜尋"),
                    leading: new Icon(Icons.search),
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() => pageIndex = 3);
                    }),
                new ListTile(
                    title: new Text("中藥方劑搜尋"),
                    leading: new Icon(Icons.search),
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() => pageIndex = 4);
                    }),
              ],
            ),
          ),
        ),
        body: Scaffold(
            body: _changePage(pageIndex)));
  }
}
