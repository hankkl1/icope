// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:icope/enterpage.dart';
import 'package:icope/noti_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotiService().initNotification();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: EnterPage(),
    );
  }
}