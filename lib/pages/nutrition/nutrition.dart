// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:icope/homepage.dart';
import 'package:icope/pages/mobility/mobility.dart';
import 'package:icope/pages/nutrition/nutrition_forward.dart';
import 'package:icope/enterpage.dart';
import 'package:icope/noti_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:icope/tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:icope/stt.dart';

class Nutrition extends StatefulWidget {
  final bool isZh;
  const Nutrition({super.key, required this.isZh});

  @override
  State<Nutrition> createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {

  final player = AudioPlayer();
  bool isTTS = false;
  bool isOK = false;

  bool weightEntered = false; //to check whether the user entered weight or not
  bool heightEntered = false; //to check whether the user entered height or not
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  double? weight; //to record the user's weight
  double? height; // to record the user's height

  final List<String> _questions = [
    "請輸入您的體重(公斤)",
    "請輸入您的身高(公分)",
    "您是否無意識地在過去三個月內體重減少三公斤？",
    "您是否最近食慾不振？",
  ];

  int _currentIndex = 0; //pointer of the question
  int _score = 0; 

  void _answer(bool isYes) {
    if (isYes) _score++;

    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      String message;
      Widget nextPage;

      if (_score >= 1) {
        message = "您可能有營養方面的風險，建議多加留意並進一步檢測";
        nextPage = NutritionForward(isZh: widget.isZh, weight: weight!, height: height!);
      } else {
        isOK = true;
        message = "目前無明顯營養方面的風險，請每六個月持續追蹤";
        nextPage = EnterPage();
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Icon(Icons.warning_amber),
                ),
                SizedBox(width: 6,),
                Text(
                  "提醒",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Text(
              message,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (isOK) {
                    NotiService().showNotifications(
                      title: "通知！",
                      body: "請六個月後再進行一次檢測，並且持續追蹤",
                    );
                  }
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => nextPage),
                  );
                },
                child: Text(
                  "確定",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void _submitWeight() {
    final weightInput = double.tryParse(weightController.text);
    if (weightInput != null && weightInput > 0) {
      setState(() {
        weight = weightInput;
        weightEntered = true; 
        _currentIndex++;
      });
    } 
    else {
      //error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text(
              "請輸入有效的體重！",
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

  void _submitHeight() {
    final heightInput = double.tryParse(heightController.text);
    if (heightInput != null && heightInput > 0) {
      setState(() {
        height = heightInput;
        heightEntered = true; 
        _currentIndex++;
      });
    } 
    else {
      //error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text(
              "請輸入有效的身高！",
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
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.indigo),
        title: Text(
          "營養檢測",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: List.generate(_questions.length, (index) {
                  final isActive = index <= _currentIndex;
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      height: 10,
                      decoration: BoxDecoration(
                        color: isActive ? Colors.lightBlue[300] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 60,
              ),
              IconButton(
                onPressed: () async {  
                  if (widget.isZh){
                    String? zh_path = await processAudioFile(_questions[_currentIndex], "zh");
                    player.setFilePath(zh_path!);
                    player.play();
                    print("playing");
                  }
                  else{
                    String? zh_path = await processAudioFile(_questions[_currentIndex], "tw");
                    player.setFilePath(zh_path!);
                    player.play();
                    print("playing");
                  }
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
              if (weightEntered) ...[
                if (heightEntered) ...[
                  Column(
                    children: [
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
                          const SizedBox(height: 20),
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
                      //debug
                      //const SizedBox(height: 20),
                      //Text("目前分數: $_score"),
                      //const SizedBox(height: 10),
                      //Text("你的體重: $weight 公斤"),
                      //const SizedBox(height: 10),
                      //Text("你的身高: $height 公分"),
                    ],
                  )
                ]
                else ...[
                  Column(
                  children: [
                    SizedBox(height: 20),
                    TextField(
                      controller: heightController,
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
                        hintText: "請輸入您的身高",
                      ),
                      cursorColor: Colors.blue,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitHeight,
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
              ]
              else ...[
                Column(
                  children: [
                    SizedBox(height: 20),
                    TextField(
                      controller: weightController,
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
                        hintText: "請輸入您的體重",
                      ),
                      cursorColor: Colors.blue,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitWeight,
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
            ],
          ),
        )
      ),
    );
  }
}