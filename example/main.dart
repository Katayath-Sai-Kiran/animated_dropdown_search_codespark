import 'package:animated_dropdown_search_codespark/animated_dropdown_search_codespark.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> data = [
    "New York",
    "Los Angeles",
    "Chicago",
    "Houston",
    "Phoenix"
  ];

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Animated Dropdown Search Example")),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedDropdownSearch(
              data: data,
              onSelected: (value) {
                print("Selected value: $value");
              },
              hint: "Search city...",
              enableSearch: true,
              shouldHighlightMatchedText: true,
              matchedTextHighlightColor: Colors.red,
              selectedHighlightColor: Colors.yellow,
              maxHeightForOptions: 200,
              scrollPercentageColorIndicator: Colors.green,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
