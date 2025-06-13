// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:icope/homepage.dart';
import 'package:icope/pages/mobility.dart';
import 'package:icope/pages/nutrition_forward.dart';

class Nutrition extends StatefulWidget {
  const Nutrition({super.key});

  @override
  State<Nutrition> createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {

  bool weightEntered = false; //to check whether the user entered weight or not
  final TextEditingController weightController = TextEditingController();
  double? weight; //to record the user's weight

  final List<String> _questions = [
    "請輸入您的體重(公斤)",
    "您是否無意識地\n在過去三個月內\n體重減少三公斤？",
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
        message = "您可能有營養風險，建議多加留意。";
        nextPage = NutritionForward();
      } else {
        message = "目前無明顯營養風險，請繼續下一步。";
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
                  Navigator.of(context).pop(); // 關閉對話框
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

  @override
  void dispose() {
    weightController.dispose();
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
                onPressed: () {  

                },
                icon: Icon(Icons.volume_up_outlined),
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
              weightEntered
              ? Column(
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
                  const SizedBox(height: 20),
                  Text("目前分數: $_score"),
                  const SizedBox(height: 10),
                  Text("你的體重: $weight 公斤"),
                ],
              )
              : Column(
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
                        fontSize: 16,
                        //fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}