import 'package:flutter/material.dart';

class OptionsWidget extends StatelessWidget {
  final List<String> options;
  final ValueChanged<String> onOptionSelected;

  const OptionsWidget({
    Key? key,
    required this.options,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((option) {
        return GestureDetector(
          onTap: () => onOptionSelected(option),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              option,
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      }).toList(),
    );
  }
}
