import 'package:flutter/material.dart';
import 'package:icope/enterpage.dart';
import 'package:icope/detail.dart';

class SuggestionItem {
  final String category;
  final String title;
  final String description;
  final String? imageUrl; 
  final String? videoUrl;

  SuggestionItem({
    required this.category, 
    required this.title, 
    required this.description,
    this.imageUrl,
    this.videoUrl,
  });
}

class SuggestionPage extends StatefulWidget {
  final List<SuggestionItem> suggestions;

  const SuggestionPage({super.key, required this.suggestions});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    icon: Icon(Icons.close), 
                  ),
                  Spacer(), // 撐開
                  Text(
                    "建議",
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
                  itemCount: widget.suggestions.length,
                  itemBuilder: (context, index) {
                    final item = widget.suggestions[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SuggestionDetailsPage(item: item),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            item.description,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
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