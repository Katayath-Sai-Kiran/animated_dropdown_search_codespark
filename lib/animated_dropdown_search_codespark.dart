import 'package:flutter/material.dart';

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
  });

  final List<String> data;
  final bool? enableSearch;
  final String? hint;
  final TextStyle? hintStyle;
  final TextStyle? optionTextStyle;
  final double? maxHeightForOptions;
  final Color? selectedHighlightColor;
  final Color? scrollPercentageColorIndicator;
  final InputBorder? border;
  final Function(String val) onSelected;

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

  @override
  void initState() {
    super.initState();

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
    double maxHeight =
        widget.maxHeightForOptions ?? MediaQuery.sizeOf(context).height * 0.4;
    List<String> data = widget.data;
    if (query.isNotEmpty && selectedCity?.toLowerCase() != query) {
      data = data.where((city) => city.toLowerCase().contains(query)).toList();
    }
    bool hasNoResults = query.isNotEmpty && data.isEmpty;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        TweenAnimationBuilder(
          duration: const Duration(milliseconds: 200),
          tween: Tween<double>(
              begin: isOptionsOpen ? maxHeight : 0,
              end: isOptionsOpen ? maxHeight : 65),
          builder: (context, value, child) {
            return Container(
              padding: const EdgeInsets.only(top: 65),
              clipBehavior: Clip.none,
              constraints: BoxConstraints(maxHeight: maxHeight),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              height: value,
              child: hasNoResults
                  ? SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: const Center(
                        child: Text(
                          'No Results!',
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        bool isSelected = data[index] == selectedCity;
                        return InkWell(
                          onTap: () {
                            widget.onSelected(data[index]);
                            setState(() {
                              isOptionsOpen = !isOptionsOpen;
                              selectedCity = data[index];
                              _searchController.text = selectedCity!;
                            });
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            child: Row(
                              children: [
                                if (isSelected)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: widget.selectedHighlightColor ??
                                          Colors.yellow[700],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    width: 5,
                                    height: 48,
                                  ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    data[index],
                                    style: widget.optionTextStyle ??
                                        TextStyle(
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: data.length,
                    ),
            );
          },
        ),
        if (isOptionsOpen)
          LayoutBuilder(builder: (context, constraints) {
            double widthPrecentage =
                (scrollPercentage / 100) * (constraints.maxWidth);
            if (widthPrecentage >= 0 &&
                widthPrecentage <= constraints.maxWidth) {
              percentage = widthPrecentage;
            }

            return Container(
              margin: const EdgeInsets.only(top: 15),
              clipBehavior: Clip.none,
              height: 45,
              width: percentage,
              decoration: BoxDecoration(
                color:
                    widget.scrollPercentageColorIndicator ?? Colors.yellow[700],
                borderRadius: BorderRadius.circular(10),
              ),
            );
          }),
        TextFormField(
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
        ),
      ],
    );
  }
}
