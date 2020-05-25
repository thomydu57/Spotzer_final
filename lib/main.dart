import 'dart:io';

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

class listImport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Import de bons sons"),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            new RaisedButton(
              child: Text("Poison _ De : Ana Poison"),
              onPressed: () {},
            ),
            new RaisedButton(
              child: Text("Gerard _ De : Sac à boulons"),
              onPressed: () {},
            ),
            new RaisedButton(
              child: Text("Une étincelle _ De : Law"),
              onPressed: () {},
            ),
            new RaisedButton(
              child: Text("Aeris Beats _ De : Chill Trap"),
              onPressed: () {},
            ),
          ],
        )));
  }

  Column lesImports()
  {

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
  StatefulWidget actualState = new pageLecture();
  int _selectedIndex = 0;
  Bibliotheque b = new Bibliotheque();

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
          actualState = new pageLecture();
          break;
        case 1:
          actualState = new pageBibliotheque();
          break;
        case 2:
          actualState = new pageRecherche();
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
