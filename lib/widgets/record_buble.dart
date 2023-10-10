import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';

import '../models/message.dart';

// ignore: must_be_immutable
class RecordBuble extends StatefulWidget {
  RecordBuble({Key? key,  required this.message}) : super(key: key);
    final MessageResponse message ;
    String audioPath = '';
    


  @override
  State<RecordBuble> createState() => _RecordBubleState();
}

class _RecordBubleState extends State<RecordBuble> {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    audioPlayer = AudioPlayer();
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
   super.initState();
  }
  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }


String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  Future<void> playRecording() async {
    try {
      //Source urlSource = UrlSource(audioPath);
      print("++++++++++");
      print(widget.message.recordUrl);
      await audioPlayer.play(UrlSource(widget.message.recordUrl));
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      print('Error Playing Recording : $e');
    }
  }

  Future<void> pauseRecording() async {
    try {
      //Source urlSource = UrlSource(audioPath);
      await audioPlayer.pause();
      setState(() {
        isPlaying = false ;
      });
    } catch (e) {
      print('Error pausing Recording : $e');
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 2, top: 8, bottom: 8, right: 2),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                        bottomRight: Radius.circular(32)),
                    color: kPrimaryColor),
                child: Row(
                  children: [
                    IconButton(onPressed:isPlaying ? pauseRecording : playRecording, color: Colors.white,icon: isPlaying ? const Icon(Icons.pause) : const Icon(Icons.play_arrow)),
                    Slider(
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble(),
                        onChanged: (value) {
                          
                          final position = Duration(seconds: value.toInt());
                          audioPlayer.seek(position);
                          audioPlayer.resume();
                        }),
                    Text(formatTime((duration - position).inSeconds)),
                  ],
                ),
              ),
            );
  }
}


class RecordBubleForFriend extends StatefulWidget {
  RecordBubleForFriend({Key? key,  required this.message}) : super(key: key);
    final MessageResponse message ;
    String audioPath = '';


  @override
  _RecordBubleStateForFriend createState() => _RecordBubleStateForFriend();
}

class _RecordBubleStateForFriend extends  State<RecordBubleForFriend> {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    audioPlayer = AudioPlayer();
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
   super.initState();
  }
  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }


String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  Future<void> playRecording() async {
    try {
      //Source urlSource = UrlSource(audioPath);
      print("++++++++++");
      print(widget.message.recordUrl);
      await audioPlayer.play(UrlSource(widget.message.recordUrl));
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      print('Error Playing Recording : $e');
    }
  }

  Future<void> pauseRecording() async {
    try {
      //Source urlSource = UrlSource(audioPath);
      await audioPlayer.pause();
      setState(() {
        isPlaying = false ;
      });
    } catch (e) {
      print('Error pausing Recording : $e');
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.only(left: 2, top: 8, bottom: 8, right: 2),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                        bottomLeft: Radius.circular(32)),
                    color: Color(0xff006D84)),
                child: Row(
                  children: [
                    IconButton(onPressed:isPlaying ? pauseRecording : playRecording, color: Colors.white,icon: isPlaying ? const Icon(Icons.pause) : const Icon(Icons.play_arrow)),
                    Slider(
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble(),
                        onChanged: (value) {
                          
                          final position = Duration(seconds: value.toInt());
                          audioPlayer.seek(position);
                          audioPlayer.resume();
                        }),
                    Text(formatTime((duration - position).inSeconds)),
                  ],
                ),
              ),
            );
  }
}