import 'dart:async';

import 'package:flutter/material.dart';

class MobilityForward extends StatefulWidget {
  const MobilityForward({super.key});

  @override
  State<MobilityForward> createState() => _MobilityForwardState();
}

class _MobilityForwardState extends State<MobilityForward> {

  bool balanceTest = true;

  final List<String> _questions = [
    "請",
    "請用您最快的速度，從椅子上站起來並坐下，並且將您的雙手交叉放置在您的胸前，\n重複五次",
    "您是否完成五次？",
  ];

  int _currentIndex = 0;
  int _score = 0;

  bool _isTiming = false;
  int _seconds = 0;
  Timer? _timer;
  int _maxSeconds = 60;

  void _startTimer() {
    setState(() {
      _seconds = 0;
      _isTiming = true;
    });

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isTiming = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
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

            ]
            else ...[
              
            ]
          ],
        ),
      ),
    );
  }
}