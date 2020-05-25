
import 'package:flutter/material.dart';

class pageRecherche extends StatefulWidget {
  @override
  _PageRechercher createState() => new _PageRechercher();
}

class _PageRechercher extends State<pageRecherche> {
  //Column colDeBase, colMorceau;

  String choix = ('aucun');

  @override
  Widget build(BuildContext context) {
    final morceauController = TextEditingController();
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      morceauController.dispose();
      super.dispose();
    }

    var buttonMorceau = new ListTile(
      title: new RaisedButton(
          child: new Text("Morceau"),
          onPressed: () {
            setState(() {
              choix = 'morceau';
            });
          }),
    );
    var buttonArtiste = new ListTile(
      title: new RaisedButton(
          child: new Text("Artiste"),
          onPressed: () {
            setState(() {
              choix = 'artiste';
            });
          }),
    );
    var buttonAlbum = new ListTile(
      title: new RaisedButton(
          child: new Text("Album"),
          onPressed: () {
            setState(() {
              choix = 'album';
            });
          }),
    );

    Widget lview;
    //Widget lr=new ListView(children: <Widget>[Text('salut')],);
    if (choix == 'aucun') {
      lview = new ListView(
        children: <Widget>[
          buttonMorceau,
          buttonArtiste,
          buttonAlbum,
        ],
      );
    } else if (choix == 'morceau') {
      lview = new ListView(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new RaisedButton(
                child: new Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    choix = 'aucun';
                  });
                },
                color: Colors.white12,
              ),
              new Expanded(
                  child: new Card(
                    child: Text('Morceau',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 30)),
                    color: Colors.amber,
                  ))
            ],
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Titre du morceau',
            ),
            //controller: morceauController,
            /*onTap: () {
              print('yessssss');

            },*/
          ),
          //lr
        ],
      );
    } else if (choix == 'artiste') {
      lview = new ListView(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new RaisedButton(
                child: new Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    choix = 'aucun';
                  });
                },
                color: Colors.white12,
              ),
              new Expanded(
                  child: new Card(
                    child: Text('Artiste',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 30)),
                    color: Colors.amber,
                  ))
            ],
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nom de l\'artiste',
            ),
          )
        ],
      );
    } else if (choix == 'album') {
      lview = new ListView(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new RaisedButton(
                child: new Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    choix = 'aucun';
                  });
                },
                color: Colors.white12,
              ),
              new Expanded(
                  child: new Card(
                    child: Text('Album',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 30)),
                    color: Colors.amber,
                  ))
            ],
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Titre de l\'album',
            ),
          )
        ],
      );
    }

    return new Container(child: lview);
  }

  void majLR(String t) {

  }
}
