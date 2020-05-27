import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotzerfinal/bibliotheque.dart';
import 'pageBibliotheque.dart';
import 'pageLecture.dart';
import 'pageRecherche.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static Bibliotheque b = new Bibliotheque();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotzer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: true,
      home: new MyHomePage(),
      //home: MyHomePage(title: 'Spotzer Home Page'),
    );
  }
}

class listImport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _listImport();
  }
}

class _listImport extends State<listImport> {
  var list = MyApp.b.getListImports;
  var random = Random();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      //list = List.generate(random.nextInt(10), (i) => "Item $i");
      list = MyApp.b.getListImports;
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Import de bons sons"),
        ),
        body: RefreshIndicator(
          key: refreshKey,
          child: ListView.builder(
            itemCount: list?.length,
            itemBuilder: (context, i) => ListTile(
              title: Text(list[i]),
              onTap: () {
                MyApp.b.ajouterUnMorceau(list[i]);
                MyApp.b.listeImports.remove(list[i]);
                refreshList();
              },
            ),
          ),
          onRefresh: refreshList,
        ));
  }



}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyHomePageState();
  }

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

/*@override
  _MyHomePageState createState() => _MyHomePageState();*/
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  Bibliotheque b = new Bibliotheque();

  static var pLecture = new pageLecture();
  static var pRecherche = new pageRecherche();
  static var pBibliotheque = new pageBibliotheque();
  StatefulWidget actualState = pLecture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        //leading: new Icon(Icons.account_box),
        title: new Text("Spotzer"),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => listImport()),
                );
              },
              color: Colors.white)
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                '''
               Spotzer,
               
    Pour vous en mettre 
      plein les ovaires !
                ''',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text('Compte'),
            ),
            ListTile(
              leading: Icon(Icons.notification_important),
              title: Text('Notifications'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Paramètres'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            title: Text('En lecture'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            title: Text('Bibliotheque'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Rechercher'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),

      //body: new PageBibliotheque(),

      body: actualState,
      /*backgroundColor: Colors.white,
      body: new Center(

        child: new Container(
          color: Colors.yellow,
          margin: EdgeInsets.all(10.0),
          height: 300,
          width: 300,
          )
        )*/
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          actualState = pLecture;
          break;
        case 1:
          actualState = pBibliotheque;
          break;
        case 2:
          actualState = pRecherche;
          break;
      }
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Lecture',
      style: optionStyle,
    ),
    Text(
      'Index 1: Bibliotheque',
      style: optionStyle,
    ),
    Text(
      'Index 2: Rechercher',
      style: optionStyle,
    ),
  ];
}
