import 'package:flutter/material.dart';

class MacroCard extends StatelessWidget {
  final String selectedGoal;
  final Map<String, double> macros;

  const MacroCard({
    super.key,
    required this.selectedGoal,
    required this.macros,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Macro Distribution for $selectedGoal",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _macroBar("Protein", macros['protein']!, Colors.red),
          _macroBar("Carbohydrates", macros['carbs']!, Colors.blue),
          _macroBar("Fat", macros['fat']!, Colors.orange),
        ],
      ),
    );
  }

  Widget _macroBar(String label, double percent, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 12)),
              Text("${(percent * 100).toInt()}%"),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: percent,
            backgroundColor: Colors.grey[200],
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}
