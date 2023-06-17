import 'package:flutter/material.dart';

const _selectedFontColor = Colors.white;
const _unselectedColor = Color(0xFFEDF8FF);

class SelectableButton extends StatelessWidget {
  const SelectableButton({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).colorScheme.primary;
    final unselectedFontColor = selectedColor;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        height: 36.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          color: isSelected ? selectedColor : _unselectedColor,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? _selectedFontColor : unselectedFontColor,
          ),
        ),
      ),
    );
  }
}
