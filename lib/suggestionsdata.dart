import 'package:icope/suggestionpage.dart';

final Map<String, List<SuggestionItem>> suggestionGroups = {
  //mobility
  'mobility_low': [
    SuggestionItem(
      category: "行動",
      title: "日常活動建議",
      description: "增加日常步行時間，例如每天散步30分鐘。",
    ),
  ],
  'resistance_bands': [
    SuggestionItem(
      category: "行動",
      title: "彈力帶訓練",
      description: "建議每天使用彈力帶做下肢伸展與抬腿訓練。",
      videoUrl: "https://www.youtube.com/watch?v=ROwOcKEKd9Q",
    ),
  ],
  'muscle_strength': [
    SuggestionItem(
      category: "行動",
      title: "肌力/握力訓練",
      description: "建議每天使用。",
    ),
  ],
  //nutrition
  'nutrition_risk': [
    SuggestionItem(
      category: "營養",
      title: "多攝取碳水化合物",
      description: "建議每天攝取碳水化合化。",
    ),
    SuggestionItem(
      category: "營養",
      title: "少量多餐",
      description: "每日4-5小餐，有助增加總攝取熱量。",
    ),
  ],
  'nutrition_non_risk': [
    SuggestionItem(
      category: "營養",
      title: "平常多喝水補充水分",
      description: "建議多喝水。",
    ),
  ],
  'protein_risk': [
    SuggestionItem(
      category: "營養",
      title: "補充蛋白質",
      description: "建議每天攝取豆腐、魚、蛋、奶等高蛋白飲食。",
    ),
  ],
  'vegfruit_risk': [
    SuggestionItem(
      category: "營養",
      title: "補充蔬果",
      description: "建議每天攝取水果和蔬菜。",
    ),
  ],
};