// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:icope/noti_service.dart';
import 'package:icope/pages/nutrition/nutrition.dart';
import 'package:icope/pages/mobility/mobility.dart';
import 'package:just_audio/just_audio.dart';
import 'package:icope/tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:icope/stt.dart';

class HomePage extends StatefulWidget {
  final ValueNotifier<bool> isZH;
  const HomePage({super.key, required this.isZH});

  @override
  State <HomePage> createState() =>  HomePageState();
}

class  HomePageState extends State <HomePage> {
  final player = AudioPlayer();
  bool isTTS = false;

  @override
  Widget build(BuildContext context) {
    double sectionWidth = MediaQuery.of(context).size.width * 0.42; 
    double sectionHeight = sectionWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "台灣版ICOPE Monitor",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: FloatingActionButton.extended(
                            onPressed:() async {
                              if (widget.isZH.value){
                                String? zh_path = await processAudioFile("切換為台語語音", "tw");
                                player.setFilePath(zh_path!);
                                player.play();
                                print("playing");
                                widget.isZH.value = false;
                              }
                              else{
                                String? zh_path = await processAudioFile("切換為中文語音", "zh");
                                player.setFilePath(zh_path!);
                                player.play();
                                print("playing");
                                widget.isZH.value = true;
                              }
                              setState(() {
                        
                              });
                            },
                            backgroundColor:  widget.isZH.value? Colors.red[300] :Colors.lime[400],
                            elevation: 0,
                            label: Text(
                              widget.isZH.value ? "中" : "台",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "請點擊以下功能進行檢測   ",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {  
                            //語音
                            if (widget.isZH.value){
                              String? zh_path = await processAudioFile("請點擊以下功能進行檢測", "zh");
                              player.setFilePath(zh_path!);
                              player.play();
                            }
                            else{
                              String? tw_path = await processAudioFile("請點擊以下功能進行檢測", "tw");
                              player.setFilePath(tw_path!);
                              player.play();
                            }
                            print("playing");
                          },
                          icon: Icon(Icons.volume_up),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FunctionSection(
                          width: sectionWidth,
                          height: sectionHeight,
                          color: Colors.lightBlue[300]!, 
                          icon: Icons.fastfood, 
                          label: "營養", 
                          onTap: () async {
                            if (widget.isZH.value){
                              String? zh_path = await processAudioFile("現在進到營養檢測", "zh");
                              player.setFilePath(zh_path!);
                              player.play();
                              print("playing");
                            }
                            else{
                              String? zh_path = await processAudioFile("現在進到營養檢測", "tw");
                              player.setFilePath(zh_path!);
                              player.play();
                              print("playing");
                            }
                            //語音
                            Navigator.push(context, MaterialPageRoute(builder:(context) => Nutrition(isZh: widget.isZH.value,)));
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        //Mobility
                        FunctionSection(
                          width: sectionWidth,
                          height: sectionHeight,
                          color: Colors.amber[300]!, 
                          icon: Icons.assist_walker, 
                          label: "行動", 
                          onTap: () async {
                            //語音
                            if (widget.isZH.value){
                              String? zh_path = await processAudioFile("現在進到行動檢測", "zh");
                              player.setFilePath(zh_path!);
                              player.play();
                              print("playing");
                            }
                            else{
                              String? zh_path = await processAudioFile("現在進到行動檢測", "tw");
                              player.setFilePath(zh_path!);
                              player.play();
                              print("playing");
                            }
                            Navigator.push(context, MaterialPageRoute(builder:(context) => Mobility(isZh: widget.isZH.value,)));
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FunctionSection(
                          width: sectionWidth,
                          height: sectionHeight,
                          color: Colors.purple[200]!, 
                          icon: Icons.remove_red_eye, 
                          label: "視力", 
                          onTap: () async {
                            if (widget.isZH.value){
                              String? zh_path = await processAudioFile("現在進到視力檢測", "zh");
                              player.setFilePath(zh_path!);
                              player.play();
                              print("playing");
                            }
                            else{
                              String? zh_path = await processAudioFile("現在進到視力檢測", "tw");
                              player.setFilePath(zh_path!);
                              player.play();
                              print("playing");
                            }
                            //語音
                            Navigator.push(context, MaterialPageRoute(builder:(context) => Nutrition(isZh: widget.isZH.value,)));
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        //Mobility
                        FunctionSection(
                          width: sectionWidth,
                          height: sectionHeight,
                          color: Colors.lime[200]!, 
                          icon: Icons.hearing, 
                          label: "聽力", 
                          onTap: () async {
                            //語音
                            if (widget.isZH.value){
                              String? zh_path = await processAudioFile("現在進到聽力檢測", "zh");
                              player.setFilePath(zh_path!);
                              player.play();
                              print("playing");
                            }
                            else{
                              String? zh_path = await processAudioFile("現在進到聽力檢測", "tw");
                              player.setFilePath(zh_path!);
                              player.play();
                              print("playing");
                            }
                            Navigator.push(context, MaterialPageRoute(builder:(context) => Mobility(isZh: widget.isZH.value,)));
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.orange[200],
                          ),
                          width: sectionWidth,
                          height: sectionHeight,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        //Mobility
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red[200],
                          ),
                          width: sectionWidth,
                          height: sectionHeight,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}


class FunctionSection extends StatefulWidget {

  const FunctionSection({
    super.key, 
    required this.color, 
    required this.width,
    required this.height,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Color color;
  final double width;
  final double height;
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  State<FunctionSection> createState() => _FunctionSectionState();
}

class _FunctionSectionState extends State<FunctionSection> {
  @override
  Widget build(BuildContext context) {
    final double iconSize = widget.width * 0.48;
    final double fontSize = widget.width * 0.18;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: widget.color,
        ),
        width: widget.width,
        height: widget.height,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Icon(
                widget.icon,
                color: Colors.white,
                size: iconSize,
              ),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}