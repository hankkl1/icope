import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Hearing extends StatefulWidget {
  const Hearing({super.key});

  @override
  State<Hearing> createState() => _HearingState();
}

class _HearingState extends State<Hearing> {
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