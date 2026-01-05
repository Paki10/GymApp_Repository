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
      icon: const Icon(Icons.menu, color: Colors.white),
      onSelected: onSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      itemBuilder: (context) => [
        _menuItem(Icons.home, 'Home', 'home'),
        _menuItem(Icons.fitness_center, 'Workouts', 'workouts'),
        _menuItem(Icons.restaurant, 'Nutrition', 'nutrition'),
        _menuItem(Icons.settings, 'Settings', 'settings'),
      ],
    );
  }

  // aparte methode = leesbaarder
  PopupMenuItem<String> _menuItem(
    IconData icon,
    String text,
    String value,
  ) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
