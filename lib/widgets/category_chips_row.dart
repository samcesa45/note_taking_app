import 'package:flutter/material.dart';

class CategoryChipsRow extends StatelessWidget {
  final List<String> categories;
  final String? selectedCategory;
  final ValueChanged<String> onCategorySelected;
  const CategoryChipsRow({
    super.key,
    this.categories = const [
      'All',
      'Important',
      'Lecture notes',
      'To-do lists',
      'Shopping List',
      'Diary',
    ],
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:
            categories.map((category) {
              final isSelected =
                  selectedCategory == category ||
                  (selectedCategory == null && category == 'All');
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (_) => onCategorySelected(category),
                  backgroundColor: Colors.white,
                  selectedColor: Theme.of(context).hintColor,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
