import 'package:entry/entry.dart';
import 'package:flutter/material.dart';

/// A customizable dropdown search widget with animated opening and closing, search functionality,
/// and optional highlighted matched text.
class AnimatedDropdownSearch extends StatefulWidget {
  const AnimatedDropdownSearch({
    super.key,
    required this.data,
    required this.onSelected,
    this.hint,
    this.hintStyle,
    this.optionTextStyle,
    this.selectedHighlightColor,
    this.enableSearch,
    this.maxHeightForOptions,
    this.scrollPercentageColorIndicator,
    this.border,
    this.minCharactersToHighlight,
    this.shouldHighlightMatchedText,
    this.matchedTextHighlightColor,
    this.enableAdaptivePositioning,
  });

  /// List of strings to display in the dropdown.
  final List<String> data;

  /// Callback function when an item is selected.
  final Function(String val) onSelected;

  /// Placeholder text for the search field.
  final String? hint;

  /// Style for the hint text.
  final TextStyle? hintStyle;

  /// Style for the dropdown options.
  final TextStyle? optionTextStyle;

  /// Color for the selected option highlight.
  final Color? selectedHighlightColor;

  /// Color for the scroll percentage indicator.
  final Color? scrollPercentageColorIndicator;

  /// Color for the matched text highlight.
  final Color? matchedTextHighlightColor;

  /// Boolean to enable/disable search functionality.
  final bool? enableSearch;

  /// Boolean to enable/disable adaptive positioning on the options based on the available space and maxheight (top/bottom)
  final bool? enableAdaptivePositioning;

  /// Boolean to enable/disable highlighting matched text.
  final bool? shouldHighlightMatchedText;

  /// Maximum height for the options dropdown.
  final double? maxHeightForOptions;

  /// Minimum number of characters before highlighting matched text.
  final int? minCharactersToHighlight;

  /// Input border for the search field.
  final InputBorder? border;

  @override
  State<AnimatedDropdownSearch> createState() => _AnimatedDropdownSearchState();
}

class _AnimatedDropdownSearchState extends State<AnimatedDropdownSearch> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFieldFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  String get query => _searchController.text.trim().toLowerCase();
  bool isOptionsOpen = false;
  String? selectedCity;
  double scrollPercentage = 0;
  double percentage = 0;

  final GlobalKey _searchFieldKey = GlobalKey();

  final OverlayPortalController _tooltipController = OverlayPortalController();

  @override
  void initState() {
    super.initState();

    // Add a listener to update the scroll percentage

    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      _scrollController.addListener(() {
        setState(() {
          scrollPercentage = ((_scrollController.offset /
                  _scrollController.position.maxScrollExtent) *
              100);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Offset? position;
    bool shouldDisplayTop = false;
    double maxHeight =
        widget.maxHeightForOptions ?? MediaQuery.sizeOf(context).height * 0.4;
    List<String> data = List.from(widget.data);

    // Filter the data based on the query
    if (query.isNotEmpty && selectedCity?.toLowerCase() != query) {
      data = data.where((city) => city.toLowerCase().contains(query)).toList();
    }

    final double height = MediaQuery.sizeOf(context).height;
    bool hasNoResults = query.isNotEmpty && data.isEmpty;
    if (isOptionsOpen) {
      RenderBox? renderBox =
          _searchFieldKey.currentContext?.findRenderObject() as RenderBox;
      position = renderBox.localToGlobal(Offset.zero);
    }
    if (selectedCity != null) {
      data.sort((a, b) {
        if (a == selectedCity) return -1; // 'a' should come before 'b'
        if (b == selectedCity) return 1; // 'b' should come after 'a'
        return a.compareTo(b); // Alphabetical order
      });
    }

    if (position != null && widget.enableAdaptivePositioning == true) {
      if ((height - position.dy) < maxHeight) {
        shouldDisplayTop = true;
      }
    }

    final double? bottom =
        shouldDisplayTop ? height - (position?.dy ?? 0) - 10 : null;
    final double? top = shouldDisplayTop
        ? null
        : position != null && isOptionsOpen && position.dy > 0
            ? (position.dy + 50)
            : null;
    return Column(
      children: [
        OverlayPortal(
          controller: _tooltipController,
          overlayChildBuilder: (context) => Positioned(
            left: 0,
            right: 0,
            bottom: bottom,
            top: top,
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 200),
              tween: Tween<double>(
                  begin: isOptionsOpen ? 0 : maxHeight,
                  end: isOptionsOpen ? maxHeight : 0),
              builder: (context, value, child) {
                return Container(
                  margin: const EdgeInsets.all(16),
                  clipBehavior: Clip.antiAlias,
                  constraints: BoxConstraints(maxHeight: value),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: hasNoResults
                      ? noResultsWidget(context)
                      : optionsListviewWidget(data),
                );
              },
            ),
          ),
          child: searchFieldWidget(),
        ),
      ],
    );
  }

  Widget optionsListviewWidget(List<String> data) {
    List<String> options = List.from(data);
    // options.sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        scroolPercentageWidget(),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final bool isSelected = options[index] == selectedCity;
              final bool shouldHighlightText = (query.isNotEmpty &&
                      (query.length >=
                          (widget.minCharactersToHighlight ?? 3))) &&
                  widget.shouldHighlightMatchedText == true &&
                  !isSelected;

              return Entry.offset(
                yOffset: index == 0 ? 0 : 5,
                key: UniqueKey(),
                delay: Duration(milliseconds: index == 0 ? 0 : index * 20),
                child: InkWell(
                  onTap: () {
                    widget.onSelected(options[index]);
                    setState(() {
                      _tooltipController.toggle();
                      isOptionsOpen = !isOptionsOpen;
                      selectedCity = options[index];
                      _searchController.text = selectedCity!;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: optionsCard(
                      isSelected, shouldHighlightText, options, index),
                ),
              );
            },
            itemCount: data.length,
          ),
        ),
      ],
    );
  }

  TextFormField searchFieldWidget() {
    return TextFormField(
      readOnly: widget.enableSearch != true,
      focusNode: _searchFieldFocusNode,
      controller: _searchController,
      onChanged: (val) => setState(() {}),
      onTapAlwaysCalled: true,
      onTap: () {
        setState(() {
          isOptionsOpen = !isOptionsOpen;
        });
      },
      decoration: InputDecoration(
          suffixIcon: isOptionsOpen
              ? IconButton(
                  onPressed: () {
                    if (query.isNotEmpty) {
                      setState(() {
                        selectedCity = null;
                        _searchController.clear();
                      });
                    } else {
                      setState(() {
                        _searchFieldFocusNode.unfocus();
                        _searchController.clear();
                        selectedCity = null;
                        isOptionsOpen = !isOptionsOpen;
                      });
                    }
                  },
                  icon: const Icon(Icons.close))
              : const Icon(Icons.keyboard_arrow_down_outlined),
          fillColor: Colors.white,
          filled: true,
          hintStyle: widget.hintStyle,
          hintText: widget.hint,
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: widget.border ??
              OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
          focusedBorder: widget.border ??
              OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
          border: widget.border ??
              OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10))),
    );
  }

  LayoutBuilder scroolPercentageWidget() {
    return LayoutBuilder(builder: (context, constraints) {
      double widthPrecentage =
          (scrollPercentage / 100) * (constraints.maxWidth);
      if (widthPrecentage >= 0 && widthPrecentage <= constraints.maxWidth) {
        percentage = widthPrecentage;
      }

      return Container(
        margin: const EdgeInsets.only(top: 15),
        clipBehavior: Clip.none,
        height: 45,
        width: percentage,
        decoration: BoxDecoration(
          color: widget.scrollPercentageColorIndicator ?? Colors.yellow[700],
          borderRadius: BorderRadius.circular(10),
        ),
      );
    });
  }

  Card optionsCard(
      bool isSelected, bool shouldHighlightText, List<String> data, int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      child: Row(
        children: [
          if (isSelected)
            Container(
              decoration: BoxDecoration(
                color: widget.selectedHighlightColor ?? Colors.yellow[700],
                borderRadius: BorderRadius.circular(8),
              ),
              width: 5,
              height: 48,
            ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: shouldHighlightText
                ? Text.rich(highlightQueryInString(query, data[index],
                    widget.matchedTextHighlightColor ?? Colors.red))
                : Text(
                    data[index],
                    style: widget.optionTextStyle ??
                        TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                  ),
          ),
        ],
      ),
    );
  }

  SizedBox noResultsWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: const Center(
        child: Text(
          'No Results!',
          style: TextStyle(
            fontSize: 19,
          ),
        ),
      ),
    );
  }

  TextSpan highlightQueryInString(
      String query, String target, Color highlightColor) {
    List<TextSpan> spans = [];
    int startIndex = 0;

    while (startIndex < target.length) {
      // Find the start index of the next occurrence of the query in the target string
      int index = target.toLowerCase().indexOf(query.toLowerCase(), startIndex);

      if (index == -1) {
        // If no more matches, add the remaining part of the target string
        spans.add(TextSpan(text: target.substring(startIndex)));
        break;
      }

      // Add the text before the match
      if (index > startIndex) {
        spans.add(TextSpan(text: target.substring(startIndex, index)));
      }

      // Add the matched part with the highlight color
      spans.add(TextSpan(
        text: target.substring(index, index + query.length),
        style: TextStyle(backgroundColor: highlightColor),
      ));

      // Move the start index past the matched part
      startIndex = index + query.length;
    }

    return TextSpan(children: spans);
  }
}
