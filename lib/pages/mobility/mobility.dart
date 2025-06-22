// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:icope/pages/mobility/mobility_forward.dart';
import 'package:icope/homepage.dart';

class Mobility extends StatefulWidget {
  const Mobility({super.key});

  @override
  State<Mobility> createState() => _MobilityState();
}

class _MobilityState extends State<Mobility> {

  final List<String> _questions = [
    "請輸入您的年齡",
    "請將雙手交叉放於胸前，從椅子站起來和坐下連續進行五次",
    "您是否完成五次？",
  ];

  int _currentIndex = 0;
  int _score = 0;
  
  final TextEditingController ageController = TextEditingController();
  int? age; //to record the user's age

  bool _uButtonPressed = false; //understand button
  bool _isTiming = false;
  double _seconds = 0.0;
  Timer? _timer;
  double _maxSeconds = 60.0;

  void _startTimer() {
    setState(() {
      _seconds = 0.0;
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
    });
  }

  void _answer(bool isYes) {
    if (!isYes) _score++;
    _stopTimer();

    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _uButtonPressed = false; 
      });
    } else {
      String message;
      Widget nextPage;

      if (_score >= 1 || (age! < 80 && _seconds > 14) || (age! >= 80 && _seconds > 16)) {
        message = "您可能有行動風險，建議多加留意。";
        nextPage = MobilityForward();
      } else {
        message = "目前無明顯行動風險，請繼續下一步。";
        nextPage = HomePage();
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("提醒"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => nextPage),
                  );
                },
                child: Text("確定"),
              ),
            ],
          );
        },
      );
    }
  }

  void _submitAge() {
    final ageInput = int.tryParse(ageController.text);
    if (ageInput != null && ageInput > 0) {
      setState(() {
        age = ageInput;
        _currentIndex++;
      });
    } 
    else {
      //error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text(
              "請輸入有效的年齡！",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFirstQuestion = _currentIndex == 1;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.indigo),
        title: Text(
          "行動檢測",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: List.generate(_questions.length, (index) {
                final isActive = index <= _currentIndex;
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    height: 10,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.amber[300] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 10),
            if (_currentIndex == 0) ...[
              SizedBox(
                height: 60,
              ),
              IconButton(
                onPressed: () {  
                  //語音
                },
                icon: Icon(Icons.volume_up),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                _questions[_currentIndex],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  ),
                textAlign: TextAlign.center,
              ),
              Column(
                children: [
                  SizedBox(height: 20),
                  TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Colors.grey, 
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Colors.grey, 
                        width: 2.0,
                      ),
                    ),
                      hintText: "請輸入您的年齡",
                    ),
                    cursorColor: Colors.blue,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitAge,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )
                    ),
                    child: Text(
                      "送出",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ]
            else if (isFirstQuestion && !_uButtonPressed) ...[
              IconButton(
                onPressed: () {
                  //語音
                },
                icon: Icon(Icons.volume_up),
              ),
              Text(
                "請依照指示動作",
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 25
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                _questions[_currentIndex],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.grey[800]),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  "assets/gif/sitstand.gif",
                  width: 330,
                  height: 330,
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
              )
            ] //timer
            else if (isFirstQuestion && _uButtonPressed) ...[
              Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  IconButton(
                    onPressed: () {
                      //語音
                    },
                    icon: Icon(Icons.volume_up),
                  ),
                  Text(
                    "若無法完成，請直接按停止計時",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 50,
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
                    height: 40,
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
                      onPressed: () => _answer(true),
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
                  SizedBox(height: 10),
                ],
              )
            ]
            else ...[
              IconButton(
                onPressed: () {
                  //語音
                },
                icon: Icon(Icons.volume_up),
              ),
              SizedBox(height: 10),
              Text(
                _questions[_currentIndex],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _answer(true),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "是",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _answer(false),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "否",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[300],
                      ),
                    ),
                  ),
                ],
              ),
            ],
            //debug
            //SizedBox(height: 20),
            //Text("年齡: $age"),
            //SizedBox(height: 20),
            //Text("目前分數: $_score"),
            //SizedBox(height: 20),
            //Text("總共時間: $_seconds"),
          ],
        ),
      ),
    );
  }
}
