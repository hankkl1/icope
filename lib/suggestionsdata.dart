import 'package:icope/suggestionpage.dart';

final Map<String, List<SuggestionItem>> suggestionGroups = {
  //mobility
  'health_education_normal': [
    SuggestionItem(
      category: "行動",
      title: "衛教重點初階",
      description: "維持正常健康行為",
      detail: "請根據以下建議維持正常健康狀況",
      examples: [
        SuggestionExample(
          text: "維持健康習慣，定期健康檢查",
          imageUrl: "assets/images/health_check.jpg",
        ),
        SuggestionExample(
          text: "預防及管理慢性病",
          description: "避免慢性病惡化",
          imageUrl: "assets/images/chronic_check.png",
        ),
        SuggestionExample(
          text: "維持運動習慣",
          description: "可在運動前使用「新版身體活動準備度問卷」評估自身狀況",
          imageUrl: "assets/images/PAR-Q+_sheet.png",
        ),
        SuggestionExample(
          text: "額外衛教資訊",
          imageUrl: "assets/images/health_education.jpg",
        ),
      ]
    ),
  ],
  'health_education_limit1': [
    SuggestionItem(
      category: "行動",
      title: "衛教重點二階",
      description: "養成良好習慣並確保安全與飲食",
      detail: "請另外再參考初階衛教，並特別注意以下建議",
      examples: [
        SuggestionExample(
          text: "需要營養衛教",
          description: "建議進行本APP的營養檢測"
        ),
        SuggestionExample(
          text: "養成運動習慣",
          description: "若無規律運動習慣，可以循序漸進的增加運動頻率及強度",
        ),
        SuggestionExample(
          text: "長者活力體能訓練運動",
          description: "適合衰弱前期者",
          videoUrl: "https://youtu.be/pwu4uGDn2Nc?si=SzZvezpmgfI77nvK"
        ),
        SuggestionExample(
          text: "減少環境危險因子",
          description: "可以增加家中照明、扶手、沐浴椅",
          imageUrl: "assets/images/bath_chair.jpg"
        ),
      ]
    ),
  ],
  'health_education_limit2': [
    SuggestionItem(
      category: "行動",
      title: "衛教重點中階",
      description: "需要體能訓練，建議轉介機構",
      detail: "請另外再參考二階及初階衛教，並特別注意以下建議",
      examples: [
        SuggestionExample(
          text: "建議進行體能訓練",
          description: "長者活力體能訓練運動，適合衰弱者",
          videoUrl: "https://www.youtube.com/watch?v=11x5X6dDbvc"
        ),
        SuggestionExample(
          text: "建議進行轉介",
        ),
        SuggestionExample(
          text: "復健科",
          description: "物理治療(主/被動關節運動)、步態平衡訓練、輔具評估等",
          imageUrl: "assets/images/rehabilitation.jpg"
        ),
        SuggestionExample(
          text: "高齡(老年)醫學科",
          description: "老年病症候群篩檢與處置",
          imageUrl: "assets/images/geriatric_medicine.png"
        ),
      ]
    ),
  ],
  'health_education_limit3': [
    SuggestionItem(
      category: "行動",
      title: "衛教重點高階",
      description: "需要體能訓練，建議轉介機構",
      detail: "請另外再參考中階、二階及初階衛教，並特別注意以下建議",
      examples: [
        SuggestionExample(
          text: "建議進行體能訓練",
          description: "長者活力體能訓練運動，適合失能者",
          videoUrl: "https://www.youtube.com/watch?v=mUPqkDisQDI"
        ),
        SuggestionExample(
          text: "建議進行轉介",
        ),
        SuggestionExample(
          text: "復健科",
          description: "物理治療、職能治療"
        ),
        SuggestionExample(
          text: "高齡(老年)醫學科",
          description: "整合照護"
        ),
        SuggestionExample(
          text: "社福機構",
          description: "若家庭因照護分擔或經濟出現照護問題，可以轉介社工師",
          imageUrl: "assets/images/social_welfare.png"
        ),
      ]
    ),
  ],
  'exercise': [
    SuggestionItem(
      category: "行動",
      title: "日常運動建議",
      description: "改善自身活動力",
      detail: "您可以每週做至少150分鐘的中等強度運動，或是75分鐘的高強度運動，或等量組合。"
        "若需加強也可改為300分鐘的中等強度運動，或150分鐘高強度運動，或等量組合。",
      examples: [
        SuggestionExample(
          text: "長者活力體能訓練健康者運動",
          videoUrl: "https://youtu.be/eJhtVhSga_Q?si=rqemcwhXyI3zBBBA",
        ),
        SuggestionExample(
          text: "有氧運動健康操",
          videoUrl: "https://www.youtube.com/watch?v=7pIeSsndwbA",
        ),
        SuggestionExample(
          text: "心肺耐力訓練",
          videoUrl: "https://www.youtube.com/watch?v=IRO6OY64jp0",
        ),
      ]
    ),
  ],
  'balance': [
    SuggestionItem(
      category: "行動", 
      title: "預防跌倒",
      description: "增強自身柔軟度和平衡力，並加強安全措施",
      detail: "若您的行動較為不便，可嘗試做瑜伽運動來增進柔軟度，每週3天以上",
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
        SuggestionExample(
          text: "長者防跌海報",
          imageUrl: "assets/images/fall_prevention.png",
        ),
      ]
    ),
  ],
  'muscle_strength': [
    SuggestionItem(
      category: "行動",
      title: "肌力和握力訓練",
      description: "增加肌力和肌耐力",
      detail: "若您的行動能力較好，可以透過每週至少2天的肌力活動，增加自身的肌力和肌耐力",
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
  'nutrition_education_normal': [
    SuggestionItem(
        category: "營養",
        title: "營養建議初階",
        description: "需要多注意營養狀況",
        detail: "可以根據以下資訊促進營養狀況，並注意身體健康",
        examples: [
          SuggestionExample(
            text: "均衡飲食並搭配運動",
            description: "為獲取足夠營養，可以參考以下表格安排日常飲食",
            imageUrl: "assets/images/everyday_meal.jpg"
          ),
          SuggestionExample(
            text: "注意口內狀況",
            description: "例如口牙、咀嚼、吞嚥、食慾等，若狀況不佳導致營養攝取不足，建議使用營養密度高的食物或口服營養補充品",
          ),
          SuggestionExample(
            text: "營養密度高的食物",
            description: "若口內狀況狀況不佳導致營養攝取不足，可以優先選擇這類食物攝取",
            imageUrl: "assets/images/high_nutrition_food.jpg",
          ),
          SuggestionExample(
            text: "口服營養補充品",
            description: "這類食品為輔助品，切勿濫用",
            imageUrl: "assets/images/oral_supplemental.jpg",
            videoUrl: "https://www.youtube.com/watch?v=4lRO0BAjAvo",
          ),
          SuggestionExample(
            text: "多曬太陽",
            description: "日曬能有助於皮膚合成維生素D，建議多去戶外曬10到15分鐘的太陽！",
            imageUrl: "assets/images/sunbathe.png"
          ),
          SuggestionExample(
            text: "定期測體重",
            description: "測體重是監測長者營養狀況的重要指標！",
          ),
          SuggestionExample(
            text: "熱量與蛋白質攝取",
            description: "可以參考食物攝取的建議！",
          ),
          SuggestionExample(
            text: "額外衛教資訊",
            imageUrl: "assets/images/health_education.jpg",
          ),
        ]
    ),
  ],
  'nutrition_education_limited': [
    SuggestionItem(
        category: "營養",
        title: "營養建議中階",
        description: "特別注意營養攝取及口腔狀況",
        detail: "請另外再參考初階衛教營養建議，並特別注意以下事項",
        examples: [
          SuggestionExample(
              text: "疾病史與用藥史",
              description: "這些可能影響營養狀況需要特別評估",
          ),
          SuggestionExample(
            text: "體重控制",
            description: "對於衰弱及多重共病長者的體重建議維持在正常至微胖的狀態。"
              "而原本過重的長者則維持常態、穩定的體重較為恰當",
          ),
          SuggestionExample(
            text: "注意咳嗆狀況",
            description: "如有咳嗆現象，建議評估咳嗆原因，並注意吞嚥技巧",
            videoUrl: "https://youtu.be/j0ClO9JBSsQ?si=2l8VKiBHn014kUt_",
          ),
          SuggestionExample(
            text: "熱量與蛋白質攝取",
            description: "可以參考食物攝取的建議！",
          ),
          SuggestionExample(
            text: "腎功能不佳者",
            description: "建議監測腎功能",
          ),
          SuggestionExample(
            text: "社會支持與參與",
            description: "鼓勵老者與家人一同用餐或社交用餐！",
            imageUrl: "assets/images/social_meal.jpg"
          ),
          SuggestionExample(
            text: "建議進行轉介",
          ),
          SuggestionExample(
            text: "社區營養推廣中心",
            description: "有社區營養師提供飲食指導及追蹤",
            imageUrl: "assets/images/CNPC.jpg"
          ),
          SuggestionExample(
              text: "家醫科或內科",
              description: "疾病評估與診療(如慢性疾病、癌症、感染等)",
          ),
          SuggestionExample(
              text: "營養諮詢門診",
              description: "提供完善的營養評估、衛教、提供長者更專業的建議",
              imageUrl: "assets/images/nutrition_counsel.png",
          ),
          SuggestionExample(
              text: "牙科",
              description: "評估口腔牙齒健康及吞嚥狀況等問題",
          ),
          SuggestionExample(
              text: "復健科",
              description: "評估吞嚥、咳嗆問題及提供吞嚥姿勢等訓練",
              imageUrl: "assets/images/swallowing_training.png"
          ),
        ]
    ),
  ],
  'nutrition_education_highRisk': [
    SuggestionItem(
        category: "營養",
        title: "營養建議高階",
        description: "建議轉介專業服務機構",
        detail: "請另外再參考初階及中階衛教營養建議，並建議轉介專業機構",
        examples: [
          SuggestionExample(
              text: "長照機構",
              description: "提供送餐服務",
              imageUrl: "assets/images/CNPC.jpg"
          ),
          SuggestionExample(
            text: "社福機構",
            description: "由社工師協助評估",
          ),
          SuggestionExample(
              text: "高齡(老年)醫學科",
              description: "若六大評估項(除視聽障礙外)出現兩項以上的問題時，評估疾病與用藥、並進行血液檢查",
              imageUrl: "assets/images/geriatric_medicine.png"
          ),
        ]
    ),
  ],
  'normal_nutrition': [
    SuggestionItem(
      category: "營養",
      title: "平日飲食與水分建議",
      description: "促進良好營養的健康生活方式",
      detail: "若您沒有因為藥物或疾病限制飲食，建議您多攝取原型食物和多補充水份",
      examples: [
        SuggestionExample(
            text: "熱量攝取建議",
            description: "建議每天攝取每公斤體重約30大卡的熱量",
            imageUrl: "assets/images/eating.png"
        ),
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
          text: "蛋白質攝取建議",
          description: "建議每天攝取每公斤體重約1至1.2克的豆腐、魚、蛋、奶等高蛋白飲食",
          imageUrl: "assets/images/protein_food.jpg"
        ),
      ]
    ),
  ],
  'at_risk_nutrition': [
    SuggestionItem(
        category: "營養",
        title: "平日飲食與水分建議",
        description: "促進良好營養的健康生活方式",
        detail: "若您沒有因為藥物或疾病限制飲食，建議您多攝取原型食物和多補充水份",
        examples: [
          SuggestionExample(
              text: "熱量攝取建議",
              description: "建議每天攝取每公斤體重約35大卡的熱量",
              imageUrl: "assets/images/eating.png"
          ),
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
              text: "蛋白質攝取建議",
              description: "建議每天攝取每公斤體重約1.2至1.5克的豆腐、魚、蛋、奶等高蛋白飲食(嚴重腎衰竭換者除外)",
              imageUrl: "assets/images/protein_food.jpg"
          ),
          SuggestionExample(
            text: "少量多餐",
            description: "每日4到5小餐，有助於增加總攝取熱量，達到每日的營養需求！",
            imageUrl: "assets/images/grazingdiet.jpg",
          ),
          SuggestionExample(
            text: "腎功能不佳者",
            description: "若腎功能狀況穩定無惡化，則不建議限制蛋白質攝取量。若是營養狀況良好的慢性腎病患者，則可考慮限制蛋白質",
            imageUrl: "assets/images/kidney_disease.png"
          ),
        ]
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