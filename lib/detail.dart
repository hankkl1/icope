import 'package:flutter/material.dart';
import 'package:icope/suggestionpage.dart';

class SuggestionDetailsPage extends StatefulWidget {
  final SuggestionItem item;

  const SuggestionDetailsPage({
    super.key,
    required this.item,
  });

  @override
  State<SuggestionDetailsPage> createState() => _SuggestionDetailsPageState();
}

class _SuggestionDetailsPageState extends State<SuggestionDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item.title,
        ),
      ),
      body: Placeholder(

      ),
    );
  }
}