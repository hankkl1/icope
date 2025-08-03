import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Vision extends StatefulWidget {
  final bool isZh;
  const Vision({super.key, required this.isZh});

  @override
  State<Vision> createState() => _VisionState();
}

class _VisionState extends State<Vision> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}