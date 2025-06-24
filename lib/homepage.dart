// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:icope/pages/nutrition/nutrition.dart';
import 'package:icope/pages/mobility/mobility.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State <HomePage> createState() =>  HomePageState();
}

class  HomePageState extends State <HomePage> {
  @override
  Widget build(BuildContext context) {
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
                        )
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
                        Expanded(
                          child: IconButton(
                            onPressed: () {  
                              //語音
                            },
                            icon: Icon(Icons.volume_up),
                          ),
                        ),
                      ],
                      
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FunctionSection(
                          color: Colors.lightBlue[300]!, 
                          icon: Icons.fastfood, 
                          label: "營養", 
                          onTap: () {
                            //語音
                            Navigator.push(context, MaterialPageRoute(builder:(context) => Nutrition()));
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        //Mobility
                        FunctionSection(
                          color: Colors.amber[300]!, 
                          icon: Icons.assist_walker, 
                          label: "行動", 
                          onTap: () {
                            //語音
                            Navigator.push(context, MaterialPageRoute(builder:(context) => Mobility()));
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
                            color: Colors.purple[200],
                          ),
                          width: 160,
                          height: 160,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        //Mobility
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.lime[200],
                          ),
                          width: 160,
                          height: 160,
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
                          width: 160,
                          height: 160,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        //Mobility
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red[200],
                          ),
                          width: 160,
                          height: 160,
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
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  State<FunctionSection> createState() => _FunctionSectionState();
}

class _FunctionSectionState extends State<FunctionSection> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: widget.color,
        ),
        width: 160,
        height: 160,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Icon(
                widget.icon,
                color: Colors.white,
                size: 65,
              ),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 36,
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