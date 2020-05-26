import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'bibliotheque.dart';

class pageLecture extends StatefulWidget {
  @override
  _PageEnLecture createState() => new _PageEnLecture();
}

class _PageEnLecture extends State<pageLecture> {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentTime = "00:00";
  String completeTime = "00:00";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      setState(() {
        currentTime = duration.toString().split(".")[0];
      });
    });

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        completeTime = duration.toString().split(".")[0];
      });
    });
  }

  Future<String> uriMusic(String s)async {
    final ByteData data = await rootBundle.load('assets/'+s);
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/'+s);
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    return tempFile.uri.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width*0.8,
          height: 80,

          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.7, left: MediaQuery.of(context).size.width*0.1),

          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50)
          ),


          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: (){
                  if(isPlaying){
                    _audioPlayer.pause();

                    setState(() {
                      isPlaying = false;
                    });
                  }else{
                    _audioPlayer.resume();

                    setState(() {
                      isPlaying = true;
                    });
                  }

                },
              )  ,

              SizedBox(width: 16,),

              IconButton(
                icon: Icon(Icons.stop),
                onPressed: (){
                  _audioPlayer.stop();

                  setState(() {
                    isPlaying = false;
                  });

                },
              ),

              Text(currentTime, style: TextStyle(fontWeight: FontWeight.w700),),

              Text(" | "),

              Text(completeTime, style: TextStyle(fontWeight: FontWeight.w300),),



            ],
          ),
        ),
        RaisedButton(
          child: Icon(Icons.audiotrack),
          onPressed: () async{
            String filePath =await uriMusic('Gerard.mp3');
            int status = await _audioPlayer.play(filePath, isLocal: true);

            if(status == 1){
              setState(() {
                isPlaying = true;
              });
            }
          },
        ),
      ],
    );

  }
}
