import 'package:flutter/material.dart';

class MenuDropdown extends StatelessWidget {
  final Function(String) onSelected;

  const MenuDropdown({
    super.key,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu),
      onSelected: onSelected,
      itemBuilder: (context) => [
        _menuItem('Home', 'home'),
        _menuItem('Workouts', 'workouts'),
        _menuItem('Nutrition', 'nutrition'),
        _menuItem('Settings', 'settings'),
      ],
    );
  }

  // aparte methode = leesbaarder
  PopupMenuItem<String> _menuItem(String text, String value) {
    return PopupMenuItem<String>(
      value: value,
      child: Text(text),
    );
  }
}
