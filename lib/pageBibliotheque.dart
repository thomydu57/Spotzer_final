import 'bibliotheque.dart';
import 'main.dart';
import 'morceau.dart';
import 'package:flutter/material.dart';

class pageBibliotheque extends StatefulWidget {

  @override
  _PageBibliotheque createState() => new _PageBibliotheque();
}

class _PageBibliotheque extends State<pageBibliotheque> {
  bool color = true;
  //Bibliotheque b = new Bibliotheque();
  //Bibliotheque b = new Bibliotheque();

  String choix = "none";

  @override
  Widget build(BuildContext context) {
    var buttonTousLesMorceaux = new ListTile(
      title: new RaisedButton(
          child: new Row(
            children: <Widget>[
              new Icon(Icons.music_note),
              new Text("  Les morceaux"),
            ],
          ),
          color: Colors.red,
          onPressed: () {
            setState(() {
              choix = "morc";
            });
          }),
    );

    var buttonLesPlaylists = new ListTile(
      title: new RaisedButton(
          child: new Row(
            children: <Widget>[
              new Icon(Icons.playlist_play),
              new Text("  Les playlists"),
            ],
          ),
          color: Colors.red,
          onPressed: () {
            setState(() {
              choix = "play";
            });
          }),
    );

    var buttonAdores = new ListTile(
      title: new RaisedButton(
          child: new Row(
            children: <Widget>[
              new Icon(Icons.favorite),
              new Text("  Les adorées"),
            ],
          ),
          color: Colors.red,
          onPressed: () {
            setState(() {
              choix = "adore";
            });
          }),
    );

    Widget listView;
    if (choix == "none") {
      listView = new ListView(
        children: <Widget>[
          buttonTousLesMorceaux,
          buttonLesPlaylists,
          buttonAdores
        ],
      );
    } else if (choix == "morc") {
      listView = new ListView(
        children: <Widget>[
          new RaisedButton(
            child: new Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                choix = "none";
              });
            },
          ),
          //Text(afficherTousMorceaux()),
          afficherMorceaux()
        ],
      );
    } else if (choix == "play") {
      listView = new ListView(
        children: <Widget>[
          new RaisedButton(
            child: new Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                choix = "none";
              });
            },
          ),
          Text("Playlists")
        ],
      );
    } else if (choix == "adore") {
      listView = new ListView(
        children: <Widget>[
          new RaisedButton(
            child: new Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                choix = "none";
              });
            },
          ),
          Text("Adorés")
        ],
      );
    }

    return new Container(child: listView);
  }

  String afficherTousMorceaux() {
    //Bibliotheque b = new Bibliotheque();
    String res = "";
    print(MyApp.b.getListGenres.length);
    for (Morceau m in MyApp.b.getListMorceaux) {
      res += m.toLabel();
    }

    return res;
  }

  afficherMorceaux() {
    Column res = new Column(
      children: <Widget>[],
    );
    for (Morceau m in MyApp.b.getListMorceaux) {
      res.children.add(new Row(
        children: <Widget>[
          /*new Expanded(child:*/
          new Container(
            child: new Card(child: Text(m.toLabel())),
            width: 350,
          ),
          new Card(
              child: new IconButton(
                  icon: new Icon(Icons.add), onPressed: () {
                    showDialog(context: context, builder: (BuildContext context){return AlertDialog(
                      title: new Text("Ajout a une playlist"),
                      content: new Column(children: <Widget>[
                        new RaisedButton(onPressed: (){MyApp.b.listePlaylists.elementAt(0).ajoutMorceauPlaylist(m);Navigator.of(context).pop();},child: new Text('Ma playlist 1')),
                        new RaisedButton(onPressed: (){MyApp.b.listePlaylists.elementAt(1).ajoutMorceauPlaylist(m);Navigator.of(context).pop();},child: new Text('Ma playlist 2')),
                      ],)
                    );},);
                
              })) /*)*/
        ],
      ));
    }
    return res;
  }
}