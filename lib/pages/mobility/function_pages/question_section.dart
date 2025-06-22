import 'dart:async';
import 'package:flutter/material.dart';

class QuestionsSection extends StatefulWidget {
  final String questionText;
  final String questionPic;
  final int currentStep;
  final Function(int seconds, int score) onTestFinished;

  const QuestionsSection({
    super.key,
    required this.questionText,
    required this.questionPic,
    required this.currentStep,
    required this.onTestFinished,
    
  });

  @override
  State<QuestionsSection> createState() => _QuestionsSectionState();
}

class _QuestionsSectionState extends State<QuestionsSection> {

  String? pic;
  bool _uButtonPressed = false;
  bool _skip = false;
  
  double _seconds = 0.0;
  double _maxSeconds = 15.0;
  bool _isTiming = false;
  Timer? _timer;

  void _startTimer() {
    setState(() {
      _seconds = 0;
      _isTiming = true;
    });

    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _seconds += 0.01;
        if (_seconds >= _maxSeconds){
          _stopTimer();
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isTiming = false;
      _uButtonPressed = false;
    });

    //score counting
    int score = 0;
    if (widget.currentStep == 0 || widget.currentStep == 1) {
      // side-by-side / semi-tandem
      score = _seconds >= 10 ? 1 : 0;
    } 
    else if (widget.currentStep == 2) {
      if (_seconds >= 10) score = 2;
      else if (_seconds >= 3) score = 1;
      else score = 0;
    }

    int record = _seconds.toInt();
    _seconds = 0.0;
    widget.onTestFinished(record, score);
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
        if (!_uButtonPressed) ... [
          IconButton(
            onPressed: () {
              //語音
            },
            icon: Icon(Icons.volume_up),
          ),
          Text(
            widget.questionText,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              widget.questionPic,
              width: 400,
              height: 400,
              fit: BoxFit.contain,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _uButtonPressed = true;
              });
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ), 
            child: Text(
              "我了解了，進入計時頁面！",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo[400],
              ),
            ),
          ),
        ]
        else ...[
          IconButton(
            onPressed: () {
              //語音
            },
            icon: Icon(Icons.volume_up),
          ),
          Text(
            "若無法維持，請直接按停止計時",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 35,
          ),
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
                    ),
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
            ElevatedButton(
              onPressed: () => _stopTimer(),
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
        ]
      ]
    );
  }
}


