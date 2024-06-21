Here is a changelog for your Animated Dropdown Search package:

# Changelog
# Changelog

# Changelog

### [2.0.0] - 2024-06-12

#### Added
- **Multiple Selection Mode:**
  - **Feature:** Introduced a boolean `multiple` constructor to distinguish between single and multiple selection modes.
  - **Details:** Added a new constructor `AnimatedDropdownSearch.multiple` specifically for multiple selection.
  - **Functionality:** Implemented the `onSelectedMultiple` callback to handle multiple selections, making it required in the multiple selection constructor.

#### Changed
- **Constructor Assertions:**
  - **Improvement:** Updated constructor assertions to ensure `onSelected` is only allowed in the single selection constructor and `onSelectedMultiple` is only allowed in the multiple selection constructor.
- **Logic Enhancement:**
  - **Functionality:** Refined internal logic to handle sorting and highlighting of options in both single and multiple selection modes.
- **Widget Methods:**
  - **Improvement:** Modified `optionsListviewWidget` and `optionsCard` methods to support both single and multiple selection scenarios.
- **Search Field Behavior:**
  - **Improvement:** Enhanced `searchFieldWidget` to correctly toggle and clear selections in both single and multiple selection modes.

#### Fixed
- **Dropdown Closure:**
  - **Bugfix:** Corrected an issue where the dropdown would not close properly after a selection in multiple selection mode.
- **Text Highlighting:**
  - **Bugfix:** Addressed a bug causing incorrect highlighting of matched text under certain conditions.

#### Example Usage
```dart
// Single selection mode
AnimatedDropdownSearch(
  data: ['Option 1', 'Option 2', 'Option 3'],
  onSelected: (val) {
    print('Selected: $val');
  },
  hint: 'Select an option',
);

// Multiple selection mode
AnimatedDropdownSearch.multiple(
  data: ['Option 1', 'Option 2', 'Option 3'],
  onSelectedMultiple: (values) {
    print('Selected values: $values');
  },
  hint: 'Select options',
);
```

### [1.0.7]

- **Fixed Screenshots:** Fixed screenshots rendering issue

### [1.0.6]

- **Fixed Screenshots:** Fixed screenshots rendering issue

### [1.0.5]

- **Fixed Screenshots:** Fixed screenshots rendering issue

### [1.0.4]

- **Fixed Screenshots:** Fixed screenshots rendering issue

### [1.0.3]

- **Fixed Screenshots:** Fixed screenshots rendering issue

### [1.0.2]

- **Fixed Screenshots:** Fixed screenshots rendering issue

### [1.0.1]

- **Fixed Screenshots:** Fixed screenshots rendering issue

### [1.0.0]

1. **Adaptive Dropdown Positioning:**
   - **Feature:** The dropdown menu now adjusts its position to display either above or below the search field based on the available space.
   - **Details:** Implemented logic to determine the position of the search field and decide if the dropdown should be displayed at the top or bottom to maximize visibility and usability.

2. **Overlay Support:**
   - **Feature:** Integrated overlay support to ensure the dropdown menu appears on top of other widgets.
   - **Details:** Utilized `OverlayPortalController` for managing the visibility of the dropdown menu, providing a seamless user experience where the dropdown remains accessible and visible regardless of other UI elements.

### [0.1.0]

- **Bug Fixes**: Addressed and resolved various bugs to improve the stability and performance of the `AnimatedDropdownSearch` package.

### [1.0.7]

 - **Fixed Screenshots:** Fixed screenshots rendering issue

### [1.0.6]

 - **Fixed Screenshots:** Fixed screenshots rendering issue

### [1.0.5]

 - **Fixed Screenshots:** Fixed screenshots rendering issue

### [1.0.4]

 - **Fixed Screenshots:** Fixed screenshots rendering issue

### [1.0.3]

 - **Fixed Screenshots:** Fixed screenshots rendering issue

### [1.0.2]

 - **Fixed Screenshots:** Fixed screenshots rendering issue

### [1.0.1]

 - **Fixed Screenshots:** Fixed screenshots rendering issue

### [1.0.0]


1. **Adaptive Dropdown Positioning:**
   - **Feature:** The dropdown menu now adjusts its position to display either above or below the search field based on the available space.
   - **Details:** Implemented logic to determine the position of the search field and decide if the dropdown should be displayed at the top or bottom to maximize visibility and usability.

2. **Overlay Support:**
   - **Feature:** Integrated overlay support to ensure the dropdown menu appears on top of other widgets.
   - **Details:** Utilized `OverlayPortalController` for managing the visibility of the dropdown menu, providing a seamless user experience where the dropdown remains accessible and visible regardless of other UI elements.

### [0.1.0]

- **Bug Fixes**: Addressed and resolved various bugs to improve the stability and performance of the `AnimatedDropdownSearch` package. These fixes ensure smoother animations, better handling of edge cases in the dropdown behavior, and improved overall user experience.


### [0.0.9]

- **Topics Added**: Added relevant topics to the package metadata for better categorization and discoverability, including Flutter, Dart, UI Components, Dropdown Menu, Animation, Search Functionality, Custom Widgets, User Interface, Highlighting, Interactive Widgets, and Sorting.


### [0.0.8]

- **Added Selected Item Sorting**: Ensured that the selected item is placed at the top of the dropdown list, with the remaining items sorted alphabetically.
- **Added Entry Animations**: Implemented entry animations for the dropdown items, adding a delay and offset for each item to create a cascading effect.


### [0.0.7]

- **Improvements**: Performance Improvements

### [0.0.6]

- **Highlighted Matched Text**: Added the ability to highlight matched text in the dropdown options based on the search query.
- **Customizable Highlight Color**: Introduced `matchedTextHighlightColor` property for setting the color of the highlighted text.
- **Minimum Characters to Highlight**: Added `minCharactersToHighlight` property to specify the minimum number of characters before highlighting matched text.


### [0.0.5]

- **Fixed Screenshots Url**: Fixed Screenshot Uri issue

### [0.0.4]

- **Fixed Selected Option**: Fixed selection option value in textformfield


### [0.0.3]

- **Example File Added**: Included a comprehensive example file demonstrating the usage of the `AnimatedDropdownSearch` widget.
- **Description Updated**: Updated the package description to provide a clearer and more concise overview.
- **Performance Improvements**: Made several performance enhancements to ensure smoother animations and faster dropdown operations.

### [0.0.2] 

- Added screenshots to enhance visualization of the `AnimatedDropdownSearch` widget in action.
- Included content in the README highlighting the features and usage of the package, accompanied by screenshots for better illustration.
- Updated the README to provide a comprehensive overview of the package and its capabilities.


This change log reflects the enhancements made in version 0.0.2, focusing on the addition of screenshots and enriched content to improve user understanding and experience with the package.

### [0.0.1] 
## Initial Release

- **Initial Release**: Launched the `AnimatedDropdownSearch` package.
- **Smooth Animations**: Implemented smooth animations for dropdown opening and closing.
- **Search Functionality**: Added search capability within the dropdown for quick filtering.
- **Customizable Styles**: Enabled customization of hint text, option text, borders, and highlight colors.
- **Selected Option Highlighting**: Highlighted the selected option with a customizable color.
- **Scroll Percentage Indicator**: Introduced a visual indicator to show the scroll percentage.
- **Max Height Configuration**: Added the ability to configure the maximum height of the dropdown.
- **Comprehensive Documentation**: Included detailed documentation and usage examples in the README.


### Features

- Smooth dropdown animation for a list of options.
- Search functionality within the dropdown to filter options.
- Customizable hint text and hint text style.
- Customizable option text style.
- Highlighting of the selected option with a customizable color.
- Configurable maximum height for the dropdown options.
- Scroll percentage indicator with customizable color.
- Customizable border for the search field.
- Callback function to handle the selection of an option.
- Adaptive dropdown positioning based on available space (top/bottom).
- Overlay support to ensure dropdown menu appears on top of other widgets.


### Planned Features
- Additional customization options for dropdown animations and styles.
- Accessibility improvements and support for different languages.
- Performance optimizations and bug fixes.

