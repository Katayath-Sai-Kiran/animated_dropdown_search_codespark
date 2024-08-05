
# Animated Dropdown Search
# Animated Dropdown Search
# Animated Dropdown Search

The Animated Dropdown Search package is a customizable Flutter widget that allows users to search and select from a list of options with a smooth animation. This package is perfect for applications that need an elegant and user-friendly dropdown search functionality.

## Features

- Smooth dropdown animation
- Search functionality within the dropdown to filter options.
- Scroll percentage indicator with customizable color.
- Callback function to handle the selection of an option.
- Customizable styles for hint text, option text, borders, and more
- Highlight selected option
- Smooth dropdown animation for a list of options.
- Customizable hint text and hint text style.
- Customizable option text style.
- Highlighting of the selected option with a customizable color.
- Configurable maximum height for the dropdown options.
- Customizable border for the search field.
- Selected Item Sorting: Ensures that the selected item appears at the top of the dropdown list, with the remaining items sorted alphabetically.
- Entry Animations: Adds entry animations to dropdown items with a cascading effect.


## Screenshot

<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/animated_dropdown_search_codespark/main/assets/300x650-02.png" alt="Screenshot 1" width="150"/>
<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/animated_dropdown_search_codespark/main/assets/300x650-03.png" alt="Screenshot 2" width="150"/>
<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/animated_dropdown_search_codespark/main/assets/300x650-05.png" alt="Screenshot 3" width="150"/>
<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/animated_dropdown_search_codespark/main/assets/300x650-06.png" alt="Screenshot 4" width="150"/>
<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/animated_dropdown_search_codespark/main/assets/300x650-07.png" alt="Screenshot 5" width="150"/>

## Installation

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  animated_dropdown_search: ^latest_version
```

Then run `flutter pub get` to install the package.

## Usage

### Single Selection Mode

Here is a simple example of how to use the Animated Dropdown Search widget in single selection mode:

```dart
import 'package:flutter/material.dart';
import 'package:animated_dropdown_search_codespark/animated_dropdown_search_codespark.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> data = ["New York", "Los Angeles", "Chicago", "Houston", "Phoenix"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Animated Dropdown Search Example")),
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
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

### Multiple Selection Mode

Here's an example of how to use the `AnimatedDropdownSearch` widget in multiple selection mode:

```dart
import 'package:flutter/material.dart';
import 'package:animated_dropdown_search_codespark/animated_dropdown_search_codespark.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> data = ["New York", "Los Angeles", "Chicago", "Houston", "Phoenix"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Animated Dropdown Search Example")),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedDropdownSearch.multiple(
              data: data,
              onSelected: (List<String> values) {
                print("Selected values: $values");
              },
              hint: "Search city...",
              enableSearch: true,
              shouldHighlightMatchedText: true,
              matchedTextHighlightColor: Colors.red,
              selectedHighlightColor: Colors.yellow,
              maxHeightForOptions: 200,
              scrollPercentageColorIndicator: Colors.green,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

## Highlighted Matched Text

To highlight the matched text while searching, set `shouldHighlightMatchedText` to `true` and specify a `matchedTextHighlightColor`. This feature highlights the matched part of the options based on the search query.

```dart
AnimatedDropdownSearch(
  data: data,
  onSelected: (value) {
    print("Selected value: $value");
  },
  shouldHighlightMatchedText: true,
  matchedTextHighlightColor: Colors.red,
);
```

## Parameters

- `data` (List<String>): The list of strings to display in the dropdown.
- `onSelected` (Function(String val)): Callback function when an item is selected.
- `onSelectedMultiple` (Function(List<String> val)): Callback function when items are selected (for multiple selection mode).
- `hint` (String?): Placeholder text for the search field.
- `hintStyle` (TextStyle?): Style for the hint text.
- `optionTextStyle` (TextStyle?): Style for the dropdown options.
- `selectedHighlightColor` (Color?): Color for the selected option highlight.
- `enableSearch` (bool?): Boolean to enable/disable search functionality.
- `maxHeightForOptions` (double?): Maximum height for the options dropdown.
- `scrollPercentageColorIndicator` (Color?): Color for the scroll percentage indicator.
- `border` (InputBorder?): Input border for the search field.
- `minCharactersToHighlight` (int?): Minimum number of characters before highlighting matched text.
- `shouldHighlightMatchedText` (bool?): Boolean to enable/disable highlighting matched text.
- `matchedTextHighlightColor` (Color?): Color for the matched text highlight.

## Example

Here is another example with more customization options:

```dart
import 'package:flutter/material.dart';
import 'package:animated_dropdown_search_codespark/animated_dropdown_search_codespark.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Animated Dropdown Search Example')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedDropdownSearch(
              data: ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry', 'Fig', 'Grapes'],
              hint: 'Select a fruit',
              hintStyle: TextStyle(color: Colors.grey),
              optionTextStyle: TextStyle(color: Colors.blue),
              onSelected: (val) {
                print('Selected: $val');
              },
              enableSearch: true,
              maxHeightForOptions: 200.0,
              selectedHighlightColor: Colors.yellow,
              scrollPercentageColorIndicator: Colors.red,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.