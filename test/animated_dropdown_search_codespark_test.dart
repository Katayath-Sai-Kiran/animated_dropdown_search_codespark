import 'package:flutter_test/flutter_test.dart';

import 'package:animated_dropdown_search_codespark/animated_dropdown_search_codespark.dart';

void main() {
  test('adds one to input values', () {
    AnimatedDropdownSearch(
      data: const [
        'one',
        'two',
      ],
      onSelected: (vasl) {},
    );
  });
}
