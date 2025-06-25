import 'dart:async';
import 'package:flutter/material.dart';
import 'package:icope/enterpage.dart';
import 'package:icope/pages/mobility/function_pages/question_section.dart';
import 'package:icope/pages/mobility/function_pages/walking_speed.dart';
import 'package:icope/pages/mobility/function_pages/sit_stand.dart';
import 'package:icope/suggestionpage.dart';
import 'package:icope/suggestionsdata.dart';

import 'package:just_audio/just_audio.dart';
import 'package:icope/tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:icope/stt.dart';

class MobilityForward extends StatefulWidget {
  final bool isZh;
  const MobilityForward({super.key, required this.isZh});

  @override
  State<MobilityForward> createState() => _MobilityForwardState();
}

class _MobilityForwardState extends State<MobilityForward> {
  final player = AudioPlayer();
  bool isTTS = false;
  bool balanceTest = true;

  final List<String> _questions = [
    "請試著並排站立至少10秒",
    "請試著半並排站立至少10秒",
    "請試著直線站立至少10秒",
    "步行速度測試",
    "椅子起站測試",
  ];

  final List<String> _pictures = [
    "assets/images/sbsp.png",
    "assets/images/stsp.png",
    "assets/images/tsp.png",
  ];

  int _currentIndex = 0;
  int _score = 0;

  void _completeTest(){
      
    List<SuggestionItem> selectedSuggestions = [];
    selectedSuggestions.addAll(suggestionGroups['health_education_normal'] ?? []);
    if ( _score <= 3) {
      selectedSuggestions.addAll(suggestionGroups['health_education_limit1'] ?? []);
      selectedSuggestions.addAll(suggestionGroups['health_education_limit2'] ?? []);
      selectedSuggestions.addAll(suggestionGroups['health_education_limit3'] ?? []);

    }
    else if ( _score <= 6){
      selectedSuggestions.addAll(suggestionGroups['health_education_limit1'] ?? []);
      selectedSuggestions.addAll(suggestionGroups['health_education_limit2'] ?? []);
    } 
    else if ( _score <= 9) {
      selectedSuggestions.addAll(suggestionGroups['health_education_limit1'] ?? []);
    }


    selectedSuggestions.addAll(suggestionGroups['exercise'] ?? []);
    selectedSuggestions.addAll(suggestionGroups['balance'] ?? []);
    selectedSuggestions.addAll(suggestionGroups['muscle_strength'] ?? []);
    
    EnterPage.historyItems.add(selectedSuggestions);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SuggestionPage(suggestions: selectedSuggestions, isZh: widget.isZh,),
      ),
    );
  }

  Widget buildDialogContent(int seconds) {
    if (seconds >= 60) {
      return Text(
        "不太好！您花了 $seconds 秒才完成",
        style: TextStyle(
          fontSize: 20,
        ),
      );
    } else if (seconds >= 16.7) {
      return Text(
        "再加強！您一共花了 $seconds 秒完成",
        style: TextStyle(
          fontSize: 20,
        ),
      );
    } else if (seconds >= 13.7) {
      return Text(
        "還可以！您一共花了 $seconds 秒完成",
        style: TextStyle(
          fontSize: 20,
        ),
      );
    } else if (seconds >= 11.2) {
      return Text(
        "還不錯！您一共花了 $seconds 秒完成",
        style: TextStyle(
          fontSize: 20,
        ),
      );
    } else {
      return Text(
        "非常好！您只花了 $seconds 秒",
        style: TextStyle(
          fontSize: 20,
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.indigo),
        title: Text(
          "進階檢測",
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
            if (_currentIndex < 3) ...[
              QuestionsSection(
                isZh: widget.isZh,
                questionText: _questions[_currentIndex],
                questionPic: _pictures[_currentIndex],
                currentStep: _currentIndex,
                onTestFinished: (seconds, score) {
                  setState(() {
                    _score += score;
                    _currentIndex++;
                  });
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Icon(Icons.done),
                          ),
                          SizedBox(width: 6,),
                          Text(
                            "完成！",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      content: seconds >= 10
                      ? Text(
                        "非常好！您完整站立了 $seconds 秒",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                      : Text(
                        "需要加強！您只站立了 $seconds 秒",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "確定",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ]
            else if (_currentIndex == 3) ...[
              WalkingSpeedTest(
                isZh: widget.isZh,
                questionText: _questions[_currentIndex],
                onFinished: (seconds, score) {
                  setState(() {
                    _score += score;
                    _currentIndex++;
                  });
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Icon(Icons.done),
                          ),
                          SizedBox(width: 6,),
                          Text(
                            "結束！",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      content: Text(
                        "您一共行走了 ${seconds.toStringAsFixed(2)} 秒",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "確定",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ]
            else ...[
              SitStandTest(
                isZh: widget.isZh,
                questionText: _questions[_currentIndex], 
                onFinished: (seconds, score) {
                  setState(() {
                    _score += score;
                    _completeTest();
                  });
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Icon(Icons.done),
                          ),
                          SizedBox(width: 6,),
                          Text(
                            "完成！",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      content: buildDialogContent(seconds),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "確定",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
            //SizedBox(height: 20),
            //Text("分數: $_score"),
          ],
        ),
      ),
    );
  }
}
