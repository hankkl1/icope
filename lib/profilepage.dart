import 'package:flutter/material.dart';
import 'package:icope/enterpage.dart';
import 'package:icope/detail.dart';
import 'package:icope/suggestionpage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final historyItems = EnterPage.historyItems;
  List<List<SuggestionItem>> showHistoryItems = [];

  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState(){
    super.initState();
    showHistoryItems = List.from(historyItems);
  }
  @override
  void dispose(){
    _searchController.dispose();
    super.dispose();
  }

  void _searchCelebrities(String keyword){
    setState(() {
      showHistoryItems = historyItems
        .where((items) =>
          items.first.category.contains(keyword)
          )
        .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text("歷史建議")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "歷史紀錄",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 50,
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: '搜尋',
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    )
                  ),
                  IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () => _searchCelebrities(_searchController.text),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount:showHistoryItems.length,
                  itemBuilder: (context, index) {
                    final group = showHistoryItems[index];
                    return ExpansionTile(
                      title: Text(
                        "${group.first.category}建議記錄 ${index + 1}",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: group.map((item) => ListTile(
                        title: RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black),
                            children: [
                              TextSpan(
                                text: item.title,
                                style: TextStyle(
                                  backgroundColor: Colors.amber[200],  // 💡 像螢光筆一樣
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Text(
                          item.description,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[800],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuggestionDetailsPage(item: item),
                            ),
                          );
                        },
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