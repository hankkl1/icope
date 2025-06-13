// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:icope/pages/nutrition.dart';
import 'package:icope/pages/mobility.dart';

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
                    Placeholder(
                      fallbackHeight: 100,
                      fallbackWidth: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Nutrition
                    FunctionSection(
                      color: Colors.lightBlue[300]!, 
                      icon: Icons.fastfood, 
                      label: "營養", 
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => Nutrition()));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Mobility
                    FunctionSection(
                      color: Colors.amber[300]!, 
                      icon: Icons.assist_walker, 
                      label: "行動", 
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => Mobility()));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.purple[200],
                      ),
                      width: 300,
                      height: 300,
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
        width: 300,
        height: 300,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Icon(
                widget.icon,
                color: Colors.white,
                size: 160,
              ),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 60,
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