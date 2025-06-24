import 'package:flutter/material.dart';
import 'package:icope/suggestionpage.dart';
import 'package:icope/suggestionsdata.dart';
import 'package:icope/enterpage.dart';

class GeneralAssessmentPage extends StatefulWidget {
  final int previousScore;
  final double BMI;
  const GeneralAssessmentPage({
    super.key,
    required this.previousScore,
    required this.BMI,
  });

  @override
  State<GeneralAssessmentPage> createState() => _GeneralAssessmentPageState();
}

class _GeneralAssessmentPageState extends State<GeneralAssessmentPage> {
  int maxScore = 30;
  bool hasProteinDeficiencyRisk = false;
  bool hasLowVegFruitIntake = false;

  final List<Question> _questions = [
    Question('7.您是否可獨立生活(非住護理之家或醫院)', ['是', '否'], [1, 0]),
    Question('8.您是否每天服用三種以上的處方藥物', ['是', '否'], [0, 1]),
    Question('9.您是否有褥瘡或皮膚潰瘍？', ['是', '否'], [0, 1]),
    Question('10.您一天吃幾餐完整餐食', ['一餐', '兩餐', '三餐'], [0, 1, 2]),
    Question('11.您的蛋白質攝取', [
      '每天乳製品',
      '每週2次以上豆/蛋類',
      '每天肉類/魚/家禽',
    ], [0.0, 0.5, 1.0], multi: true),
    Question('12.您是否每天攝取二份或以上蔬果', ['是', '否'], [1, 0]),
    Question('13.您是否每天攝取液體（含水或茶等）', ['小於3杯', '3到5杯', '大於5杯'], [0.0, 0.5, 1.0]),
    Question('14.您的進食形式為何？', ['需要他人協助', '自己吃但吃力', '可以自己吃'], [0, 1, 2]),
    Question('15.您覺得自己營養狀況為何？', ['非常不好', '不太好/不清楚', '沒有問題'], [0, 1, 2]),
    Question('16.您與同齡比較健康狀況', ['較差', '不清楚', '差不多', '較好'], [0.0, 0.5, 1.0, 2.0]),
    Question('17.您的臂中圍（MAC）', ['小於21cm', '21到21.9cm', '大於等於22cm'], [0.0, 0.5, 1.0]),
    Question('18.您的小腿圍（CC）', ['小於31cm', '大於等於31cm'], [0, 1]),
  ];

  final Map<int, dynamic> _answers = {};

  double get _score => _answers.entries.fold(0, (sum, entry) {
    final index = entry.key;
    final value = entry.value;

    if (_questions[index].multi) {
      double subtotal = 0;
      for (final i in value) {
        subtotal += _questions[index].scores[i];
      }
      return sum + subtotal;
    } else {
      return sum + _questions[index].scores[value];
    }
  });
  
  List<SuggestionItem>? get selectedSuggestions => null;

  void _submit() {
    print(widget.previousScore);

    //protein check
    final proteinSet = _answers[4] as Set<int>? ?? {};
    double proteinTotal = 0;
    for (final i in proteinSet) {
      proteinTotal += _questions[4].scores[i];
    }
    hasProteinDeficiencyRisk = proteinTotal <= 0.5;

    //vegFruit check
    final vegFruitChoice = _answers[5];
    hasLowVegFruitIntake = (vegFruitChoice != null && _questions[5].scores[vegFruitChoice] == 0);

    //score and results
    double _totalScore = _score + widget.previousScore;
    List<SuggestionItem> selectedSuggestions = [];

    if (_totalScore <= 17){
      print("營養不良");
      selectedSuggestions.addAll(suggestionGroups['malnutrition'] ?? []);
    }
    else if (_totalScore <=23){
      print("有營養不良危險");
      selectedSuggestions.addAll(suggestionGroups['at_risk_nutrition'] ?? []);
    }
    else {
      print("營養狀況良好");
      selectedSuggestions.addAll(suggestionGroups['normal_nutrition'] ?? []);
    }
    
    if (hasLowVegFruitIntake){
      selectedSuggestions.addAll(suggestionGroups['vegfruit_risk'] ?? []);
    }
    else if (hasProteinDeficiencyRisk){
      selectedSuggestions.addAll(suggestionGroups['protein_risk'] ?? []);
    }

    EnterPage.historyItems.add(selectedSuggestions!);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SuggestionPage(suggestions: selectedSuggestions),
      ),
    );
  }

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
      body: ListView.builder(
        itemCount: _questions.length,
        itemBuilder: (context, index) {
          final q = _questions[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8),
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
                            q.title, 
                            style: const TextStyle(
                              fontSize: 25, 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.volume_up),
                          onPressed: () {
                            
                          },
                        ),
                      ],
                    ),
                  ),
                  if (q.multi) //multiple choices
                    ...q.options.asMap().entries.map((entry) {
                      final i = entry.key;
                      return CheckboxListTile(
                        title: Text(
                          entry.value,
                          style: TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        value: _answers[index]?.contains(i) ?? false,
                        onChanged: (checked) {
                          setState(() {
                            _answers[index] = _answers[index] ?? <int>{};
                            if (checked!) {
                              _answers[index].add(i);
                            } else {
                              _answers[index].remove(i);
                            }
                            // 語音
                          });
                        },
                      );
                    })
                  else 
                    ...q.options.asMap().entries.map((entry) {
                      final i = entry.key;
                      return RadioListTile<int>(
                        title: Text(
                          entry.value,
                          style: TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        value: i,
                        groupValue: _answers[index],
                        onChanged: (val) {
                          setState(() {
                            _answers[index] = val;
                          });
                          // 語音
                        },
                      );
                    }),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          onPressed: _submit,
          child: const Text(
            "提交",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class Question {
  final String title;
  final List<String> options;
  final List<double> scores;
  final bool multi; //multiple choices

  Question(this.title, this.options, this.scores, {this.multi = false});
}