import 'package:animated_dropdown_search_codespark/animated_dropdown_search_codespark.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Animated Dropdown Search Example')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedDropdownSearch(
              data: const [
                'Apple',
                'Banana',
                'Cherry',
                'Date',
                'Elderberry',
                'Fig',
                'Grapes'
              ],
              hint: 'Select a fruit',
              onSelected: (val) {
                print('Selected: $val');
              },
              enableSearch: true,
              selectedHighlightColor: Colors.yellow,
              scrollPercentageColorIndicator: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
