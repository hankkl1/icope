import 'package:flutter/material.dart';
import 'package:icope/pages/nutrition/generalassesment.dart';

import 'package:just_audio/just_audio.dart';
import 'package:icope/tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:icope/stt.dart';

class NutritionForward extends StatefulWidget {
  final bool isZh;
  final double weight;
  final double height;
  const NutritionForward({
    super.key,
    required this.isZh,
    required this.weight,
    required this.height,
  });

  @override
  State<NutritionForward> createState() => _NutritionForwardState();
}

class _NutritionForwardState extends State<NutritionForward> {
  final player = AudioPlayer();
  bool isTTS = false;

  int _totalScore = 0;

  final List<Question> _questions = [
    Question(
      title: '您過去三個月中，是否因食慾不佳、消化問題、咀嚼或吞嚥困難以致進食量越來越少？',
      options: [
        Option('嚴重食慾不佳', 0),
        Option('中度食慾不佳', 1),
        Option('食慾無變化', 2),
      ],
    ),
    Question(
      title: '您近三個月體重變化為何？',
      options: [
        Option('體重減輕大於3 公斤', 0),
        Option('不知道', 1),
        Option('體重減輕 1到3 公斤', 2),
        Option('體重無改變', 3),
      ],
    ),
    Question(
      title: '您的行動力為何？',
      options: [
        Option('臥床或輪椅', 0),
        Option('可下床活動但無法自由走動', 1),
        Option('可以自由走動', 2),
      ],
    ),
    Question(
      title: '您過去三個月內是否有精神性壓力或急性疾病發作？',
      options: [
        Option('是', 0),
        Option('否', 2),
      ],
    ),
    Question(
      title: '您的神經精神問題為何？',
      options: [
        Option('嚴重癡呆或抑鬱', 0),
        Option('輕度癡呆', 1),
        Option('無精神問題', 2),
      ],
    ),
  ];

  final Map<int, int> _answers = {};

  void _onAnswer(int questionIndex, int score) {
    setState(() {
      _answers[questionIndex] = score;
    });
  }
  
  int _bmiScore(){
    double BMI = widget.weight / (widget.height * widget.height / 10000);

    if (BMI < 19) return 0;
    else if (BMI < 21) return 1;
    else if (BMI < 23) return 2;
    else return 3;

  }

  int get _scoreSum =>
      _answers.values.fold(0, (sum, element) => sum + element);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.indigo),
        title: const Text(
          '營養篩檢評估',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                final question = _questions[index];
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${index+1}. ${question.title}", 
                                style: const TextStyle(
                                  fontSize: 25, 
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.volume_up),
                              onPressed: () async {
                                if (widget.isZh){
                                  String? zh_path = await processAudioFile(question.title, "zh");
                                  player.setFilePath(zh_path!);
                                  player.play();
                                  print("playing");
                                }
                                else{
                                  String? zh_path = await processAudioFile(question.title, "tw");
                                  player.setFilePath(zh_path!);
                                  player.play();
                                  print("playing");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      ...question.options.map((option) {
                        return ListTile(
                          title: Text(
                            option.text,
                            style: TextStyle(
                              fontSize: 20, 
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          leading: Radio<int>(
                            value: option.score,
                            groupValue: _answers[index],
                            onChanged: (value) async {
                              // 播放語音
                              if (widget.isZh){
                                String? zh_path = await processAudioFile(option.text, "zh");
                                player.setFilePath(zh_path!);
                                player.play();
                                print("playing");
                              }
                              else{
                                String? zh_path = await processAudioFile(option.text, "tw");
                                player.setFilePath(zh_path!);
                                player.play();
                                print("playing");
                              }
                              _onAnswer(index, value!);
                            },
                          ),
                          onTap: () async {
                            if (widget.isZh){
                              String? zh_path = await processAudioFile(option.text, "zh");
                              player.setFilePath(zh_path!);
                              player.play();
                              print("playing");
                            }
                            else{
                              String? zh_path = await processAudioFile(option.text, "tw");
                              player.setFilePath(zh_path!);
                              player.play();
                              print("playing");
                            }
                            _onAnswer(index, option.score);
                            // 播放語音
                          },
                        );
                      }).toList(),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                _totalScore = _scoreSum + _bmiScore();
                if (_totalScore <= 11) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GeneralAssessmentPage(isZh: widget.isZh, previousScore: _totalScore, BMI: widget.weight / (widget.height * widget.height / 10000),)),
                  );
                } 
                else {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("總分"),
                      content: Text("你的總分是 $_totalScore（含 BMI 分數）\n→ 無需進一步一般評估"),
                      actions: [
                        TextButton(
                          child: const Text("關閉"),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  );
                }
              },
              child: Text(
                "提交",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Question {
  final String title;
  final List<Option> options;

  Question({required this.title, required this.options});
}

class Option {
  final String text;
  final int score;

  Option(this.text, this.score);
}