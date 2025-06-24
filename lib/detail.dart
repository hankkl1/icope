import 'package:flutter/material.dart';
//import 'package:hyperlink/hyperlink.dart';
import 'package:icope/suggestionpage.dart';

import 'package:just_audio/just_audio.dart';
import 'package:icope/tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:icope/stt.dart';

class SuggestionDetailsPage extends StatefulWidget {
  final bool isZh;
  final SuggestionItem item;

  const SuggestionDetailsPage({
    super.key,
    required this.isZh,
    required this.item,
  });

  @override
  State<SuggestionDetailsPage> createState() => _SuggestionDetailsPageState();
}

class _SuggestionDetailsPageState extends State<SuggestionDetailsPage> {
  
  final player = AudioPlayer();
  bool isTTS = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.indigo),
        title: Text(
          widget.item.title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 類別
            Row(
              children: [
                Text(
                  '分類：${widget.item.category}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey[700]),
                ),
                IconButton(
                  onPressed: () async {  
                    //語音
                    if (widget.isZh){
                      String? zh_path = await processAudioFile(widget.item.detail, "zh");
                      player.setFilePath(zh_path!);
                      player.play();
                      print("playing");
                    }
                    else{
                      String? zh_path = await processAudioFile(widget.item.detail, "tw");
                      player.setFilePath(zh_path!);
                      player.play();
                      print("playing");
                    }
                  },
                  icon: Icon(Icons.volume_up),
                ),
              ],
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${widget.item.detail}',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            if (widget.item.imageUrl != null) ...[
              Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  widget.item.imageUrl!,
                  width: 400,
                  height: 400,
                  fit: BoxFit.contain,
                ),
              ),
            ],
            if (widget.item.videoUrl != null) ...[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: TextButton.icon(
                  onPressed: () {
                    // video
                  },
                  icon: Icon(Icons.play_arrow),
                  label: Text(
                    "點擊觀看影片",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ],
            if (widget.item.examples != null && widget.item.examples!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  ...widget.item.examples!.map((example) => Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("• ${example.text}", 
                              style: TextStyle(
                                fontSize: 22, 
                                fontWeight: FontWeight.bold, 
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {  
                                //語音
                                if (widget.isZh){
                                  String? zh_path = await processAudioFile(example.text, "zh");
                                  player.setFilePath(zh_path!);
                                  player.play();
                                  print("playing");
                                }
                                else{
                                  String? zh_path = await processAudioFile(example.text, "tw");
                                  player.setFilePath(zh_path!);
                                  player.play();
                                  print("playing");
                                }
                              },
                              icon: Icon(Icons.volume_up),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        if (example.description != null) ...[
                          Container(
                            child: Padding(
                              padding: EdgeInsets.only(top: 3, left: 10, right: 10, bottom: 3),
                              child: Column(
                                children: [
                                  Text(
                                    "${example.description}",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {  
                                      //語音
                                      if (widget.isZh){
                                        String? zh_path = await processAudioFile(example.description!, "zh");
                                        player.setFilePath(zh_path!);
                                        player.play();
                                        print("playing");
                                      }
                                      else{
                                        String? zh_path = await processAudioFile(example.description!, "tw");
                                        player.setFilePath(zh_path!);
                                        player.play();
                                        print("playing");
                                      }
                                    },
                                    icon: Icon(Icons.volume_up),
                                  ),
                                ],
                              ),
                            ),
                          )
                          
                        ],
                        if (example.imageUrl != null) ...[
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Image.asset(
                                example.imageUrl!,
                                width: 300,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                        if (example.videoUrl != null) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: TextButton.icon(
                              onPressed: () {
                                
                              },
                              icon: Icon(Icons.play_arrow),
                              label: Text(
                                "點擊觀看影片",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ]
                      ],
                    ),
                  )),
                ],
              ),
          ],
        ),
      ),
    );
  }
}