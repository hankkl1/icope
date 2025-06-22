import 'package:flutter/material.dart';
import 'package:icope/enterpage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final historyItems = EnterPage.historyItems;
    return Scaffold(
      //appBar: AppBar(title: const Text("歷史建議")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {  
                      Navigator.push(context, MaterialPageRoute(builder:(context) => EnterPage()));
                    },
                    icon: Icon(Icons.arrow_back_ios_new), 
                  ),
                  Spacer(), // 撐開
                  Text(
                    "歷史紀錄",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(), // 撐開
                  SizedBox(width: 48), 
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: historyItems.length,
                  itemBuilder: (context, index) {
                    final group = historyItems[index];
                    return ExpansionTile(
                      title: Text("建議記錄 ${index + 1}"),
                      children: group.map((item) => ListTile(
                        title: Text(item.title),
                        subtitle: Text(item.description),
                      )).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}