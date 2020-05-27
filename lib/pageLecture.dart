import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'bibliotheque.dart';
import 'main.dart';
import 'morceau.dart';

class pageLecture extends StatefulWidget {
  @override
  _PageEnLecture createState() => new _PageEnLecture();
}

class _PageEnLecture extends State<pageLecture> {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentTime = "00:00";
  String completeTime = "00:00";
  String titreEnLecture = "";

  @override
  void initState() {
    super.initState();

    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      /*if (mounted) {*/
      this.setState(() {
        currentTime = duration.toString().split(".")[0];
      });
      /*}
        else
          _audioPlayer.stop();*/
    });

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      /* if (mounted) {*/
      this.setState(() {
        completeTime = duration.toString().split(".")[0];
      });
      /*}
        else
          _audioPlayer.stop();*/
    });
  }

  Future<String> uriMusic(String s) async {
    final ByteData data = await rootBundle.load('assets/' + s);
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/' + s);
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    return tempFile.uri.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.8,
          height: 80,
          margin: EdgeInsets.only(
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.7,
              left: MediaQuery
                  .of(context)
                  .size
                  .width * 0.1),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(50)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  if (isPlaying) {
                    _audioPlayer.pause();

                    setState(() {
                      isPlaying = false;
                    });
                  } else {
                    _audioPlayer.resume();

                    setState(() {
                      isPlaying = true;
                    });
                  }
                },
              ),
              SizedBox(
                width: 16,
              ),
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: () {
                  _audioPlayer.stop();

                  setState(() {
                    isPlaying = false;
                  });
                },
              ),
              Text(
                currentTime,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(" | "),
              Text(
                completeTime,
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              IconButton(icon: Icon(Icons.navigate_before),
                onPressed: () {
                  precedent();
                  setState(() {

                  });
                },

              ),
              IconButton(icon: Icon(Icons.navigate_next),
                onPressed: () {
                  suivant();
                  setState(() {

                  });
                },

              ),




            ],
          ),
        ),
        afficherMorceauxPlaylist()
      ],
    );
  }

  afficherMorceauxPlaylist() {
    Column res = new Column(
      children: <Widget>[],
    );
    for (Morceau m in MyApp.b.getListPlaylists
        .elementAt(0)
        .getMorceauxPlaylist) {
      res.children.add(new Row(
        children: <Widget>[
          /*new Expanded(child:*/
          new Container(
            child: new Card(child: Text(m.toLabel())),
            width: 350,
          ),
          new Card(
              child: new IconButton(
                  icon: new Icon((titreEnLecture==m.titreMorceau) ? Icons.pause:Icons.play_arrow), onPressed: () async {
                String filePath = await uriMusic(m.cheminMorceau);
                int status = await _audioPlayer.play(filePath, isLocal: true);
                titreEnLecture = m.titreMorceau;
                if (status == 1) {
                  setState(() {
                    isPlaying = true;
                  });
                }
              })) /*)*/
        ],
      ));
    }
    return res;
  }

  suivant() async {
    int cpt = 0;
    print(titreEnLecture);
    for (Morceau m in MyApp.b.getListPlaylists
        .elementAt(0)
        .getMorceauxPlaylist) {
      if (m.titreMorceau == titreEnLecture) {
        Morceau next;
        int nextint = cpt+1;
        if(nextint>=0&&nextint<MyApp.b.getListPlaylists.elementAt(0).getMorceauxPlaylist.length)
        {
          next = MyApp.b.getListPlaylists.elementAt(0).getMorceauxPlaylist.elementAt(nextint);
          String filePath = await uriMusic(next.cheminMorceau);
          int status = await _audioPlayer.play(filePath, isLocal: true);
          titreEnLecture = next.titreMorceau;
          if (status == 1) {
            setState(() {
              isPlaying = true;
            });
          }

        }
      }
      cpt++;
    }
  }

  precedent() async {
    int cpt = 0;
    for (Morceau m in MyApp.b.getListPlaylists
        .elementAt(0)
        .getMorceauxPlaylist) {
      if (m.titreMorceau == titreEnLecture) {
        Morceau next;
        int nextint = cpt-1;
        if(nextint>=0&&nextint<MyApp.b.getListPlaylists.elementAt(0).getMorceauxPlaylist.length)
          {
            next = MyApp.b.getListPlaylists.elementAt(0).getMorceauxPlaylist.elementAt(nextint);
            String filePath = await uriMusic(next.cheminMorceau);
            int status = await _audioPlayer.play(filePath, isLocal: true);
            titreEnLecture = next.titreMorceau;
            if (status == 1) {
              setState(() {
                isPlaying = true;
              });
          }

        }
      }
      cpt++;
    }

  }
}
