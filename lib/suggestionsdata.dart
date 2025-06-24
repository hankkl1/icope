import 'package:icope/suggestionpage.dart';

final Map<String, List<SuggestionItem>> suggestionGroups = {
  //mobility
  'normal_mobility': [
    SuggestionItem(
      category: "行動",
      title: "日常活動建議",
      description: "改善自身活動力",
      detail: "您可以每週做至少150分鐘的中等強度運動，或是75分鐘的高強度運動",
      examples: [
        SuggestionExample(
          text: "有氧運動健康操",
          videoUrl: "https://www.youtube.com/watch?v=7pIeSsndwbA",
        ),
        SuggestionExample(
          text: "心肺耐力訓練",
          videoUrl: "https://www.youtube.com/watch?v=IRO6OY64jp0",
        )
      ]
    ),
  ],
  'limited_mobility': [
    SuggestionItem(
      category: "行動", 
      title: "平衡", 
      description: "增強自身柔軟度和平衡力，預防跌到", 
      detail: "若您的行動較為不便，可嘗試做瑜伽運動來增進柔軟度",
      examples: [
        SuggestionExample(
          text: "瑜伽運動",
          imageUrl: "assets/images/yoga.png",
          videoUrl: "https://www.youtube.com/watch?v=sWWp5qWiNeY",
        ),
        SuggestionExample(
          text: "在家中安裝扶手，能夠預防跌倒",
          imageUrl: "assets/images/handrails.jpg",
        ),
      ]
    ),
  ],
  'muscle_strength': [
    SuggestionItem(
      category: "行動",
      title: "肌力和握力訓練",
      description: "增加肌力和肌耐力",
      detail: "您可以透過肌力或握力訓練，增加自身的肌力和肌耐力",
      examples: [
        SuggestionExample(
          text: "彈力帶使用",
          description: "能夠用來暖身拉筋，或是進行各部位運動",
          imageUrl: "assets/images/resistance_bands.png",
          videoUrl: "https://www.youtube.com/watch?v=9kcoayX7IGY",
        ),
        SuggestionExample(
          text: "握力訓練",
          description: "使用握力球或是軟球來增加握力",
          imageUrl: "assets/images/squeeze_ball.jpg",
          videoUrl: "https://www.youtube.com/watch?v=_vAUiqhmHX0",
        )
      ]
    ),
  ],
  //nutrition
  'normal_nutrition': [
    SuggestionItem(
      category: "營養",
      title: "平日飲食與水分建議",
      description: "促進良好營養的健康生活方式",
      detail: "若您沒有因為藥物或疾病限制飲食，建議您多攝取原型食物和多補充水份",
      examples: [
        SuggestionExample(
          text: "原型食物",
          description: "如蔬菜、水果、雞蛋等，能夠預防肥胖、維護心臟健康、穩定血糖等",
          imageUrl: "assets/images/food.png"
        ),
        SuggestionExample(
          text: "水分補充",
          description: "每天攝取約1.6公升到2公升的水份，能夠促進新陳代謝、維護健康",
          imageUrl: "assets/images/drinking.jpeg",
        ),
        SuggestionExample(
          text: "曬太陽",
          description: "日曬能有助於皮膚合成維生素D，建議多去戶外曬10到15分鐘的太陽！",
          imageUrl: "assets/images/sunbathe.png"
        ),
      ]
    ),
  ],
  'at_risk_nutrition': [
    SuggestionItem(
      category: "營養",
      title: "營養不足",
      description: "補充日常飲食營養的不足",
      detail: "若您受疾病影響身體狀況，或是體重持續減輕的話，可以考慮口服營養補充品來補充營養",
      examples: [
        SuggestionExample(
          text: "口服營養補充品",
          description: "評估自身需求並詢問營養師建議，選擇適合自己的營養補充品，但不建議過度依賴",
          imageUrl: "assets/images/oral_supplemental.jpg",
          videoUrl: "https://www.youtube.com/watch?v=4lRO0BAjAvo",
        ),
      ]
    ),
    SuggestionItem(
      category: "營養",
      title: "少量多餐",
      description: "獲得足夠營養與能量",
      detail: "每日4-5小餐，有助於增加總攝取熱量，達到每日的營養需求！",
      imageUrl: "assets/images/grazingdiet.jpg",
    ),
  ],
  'malnutrition': [
    SuggestionItem(
      category: "營養", 
      title: "立即性介入", 
      description: "尋求具備專業營養知識的人來進行評估", 
      detail: "由於您有營養不良的狀況，建議您尋求專業的營養師來幫您進行深入評估，提供客製化飲食",
      imageUrl: "assets/images/nutritionist.png",
    ),
  ],
  'protein_risk': [
    SuggestionItem(
      category: "營養",
      title: "補充蛋白質",
      description: "建議每天攝取豆腐、魚、蛋、奶等高蛋白飲食",
      detail: "每日補充足夠蛋白質能夠增加飽腹感、維持肌肉質量、提升熱量消耗和調節血糖，可以多攝取豆腐、魚、蛋、奶等高蛋白飲食",
      imageUrl: "assets/images/protein_food.jpg",
    ),
  ],
  'vegfruit_risk': [
    SuggestionItem(
      category: "營養",
      title: "補充蔬果",
      description: "建議每天攝取水果和蔬菜",
      detail: "蔬菜與水果含有豐富的維生素、礦物質及膳食纖維，可促進腸胃蠕動、腸道益菌生長、降低血膽固醇",
      imageUrl: "assets/images/fruitveg.jpg",
    ),
  ],
};