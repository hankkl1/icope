import 'package:flutter/material.dart';
import 'package:icope/homepage.dart';
import 'package:icope/profilepage.dart';
import 'package:icope/suggestionpage.dart';
import 'package:icope/suggestionsdata.dart';

class EnterPage extends StatefulWidget {
  const EnterPage({super.key});
  static List<List<SuggestionItem>> historyItems = [];
  @override
  State<EnterPage> createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> {
  int selectedIndex = 0;
  final ValueNotifier<bool> isZH = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:selectedIndex == 0 ? HomePage(isZH: isZH,) : ProfilePage(isZH: isZH,),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: '首頁'),
          NavigationDestination(icon: Icon(Icons.person), label: '個人頁面'),
        ], 
        onDestinationSelected: (int value) {
          setState(() {
            selectedIndex = value;
          });
        },
        selectedIndex: selectedIndex,
      ),
    );
  }
}