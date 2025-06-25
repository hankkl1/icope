import 'dart:async';

import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';
import 'package:icope/tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:icope/stt.dart';

class SitStandTest extends StatefulWidget {
  final bool isZh;
  final String questionText;
  final Function(int seconds, int score) onFinished;

  const SitStandTest({
    super.key, 
    required this.isZh,
    required this.questionText,
    required this.onFinished,
  });

  @override
  State<SitStandTest> createState() => _SitStandTestState();
}

class _SitStandTestState extends State<SitStandTest > {

  final player = AudioPlayer();
  bool isTTS = false;

  bool _uButtonPressed = false;
  bool _isTiming = false;
  double _seconds = 0.0;
  double _maxSeconds = 120.0;
  Timer? _timer;
  bool _is3m = true; // true : 3m, false : 4m

  void _startTimer() {
    setState(() {
      _seconds = 0;
      _isTiming = true;
    });
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _seconds += 0.01;
        if (_seconds >= _maxSeconds) {
          _stopTimer(false); 
        }
      });
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = 0.0;
      _isTiming = false;
    });
  }

  void _stopTimer(bool pressedButton) {
    _timer?.cancel();
    setState(() => _isTiming = false);

    int score = 0;
    if (!pressedButton){
      if (_seconds < 11.19) score = 4;
      else if (_seconds  <= 13.69) score = 3;
      else if (_seconds  <= 16.69) score = 2;
      else if (_seconds  <= 59.9) score = 1;
      else score = 0;
    }
    else{
      score = 0;
    }

    int time = _seconds.toInt();
    widget.onFinished(time, score);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        if (!_uButtonPressed) ...[
          IconButton(
            onPressed: () async {
              //語音
              if (widget.isZh){
                String? zh_path = await processAudioFile("${widget.questionText}, 請連續起立和坐下五次", "zh");
                player.setFilePath(zh_path!);
                player.play();
                print("playing");
              }
              else{
                String? zh_path = await processAudioFile("${widget.questionText}, 請連續起立和坐下五次", "tw");
                player.setFilePath(zh_path!);
                player.play();
                print("playing");
              }
            },
            icon: Icon(Icons.volume_up),
          ),
          Text(
            widget.questionText, 
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "請連續起立和坐下五次", 
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () => setState(() => _uButtonPressed = true),
            child: Text(
              "我了解了，進入計時頁面！",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo[400],
              ),
            ),
          ),
        ] else ...[
          //SizedBox(height: 5),
          IconButton(
            onPressed: () async {
              //語音
              if (widget.isZh){
                String? zh_path = await processAudioFile("若無法完成，請直接按無法完成", "zh");
                player.setFilePath(zh_path!);
                player.play();
                print("playing");
              }
              else{
                String? zh_path = await processAudioFile("若無法完成，請直接按無法完成", "tw");
                player.setFilePath(zh_path!);
                player.play();
                print("playing");
              }
            },
            icon: Icon(Icons.volume_up),
          ),
          Text(
            "若無法完成，請直接按無法完成",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 35),
          SizedBox(
            width: 250,
            height: 250,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: _seconds / _maxSeconds,
                  valueColor: AlwaysStoppedAnimation(Colors.amber[300]),
                  strokeWidth: 20,
                ),
                Center(
                  child: Text(
                    "${_seconds.toStringAsFixed(0)}", 
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          if (!_isTiming) ...[
            ElevatedButton(
              onPressed: _startTimer,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                "開始計時",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ]
          else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _resetTimer(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "重新計時",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  onPressed: () => _stopTimer(false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "停止計時",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => _stopTimer(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 38, 66, 190),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                "無法完成",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ]
      ],
    );
  }
}
