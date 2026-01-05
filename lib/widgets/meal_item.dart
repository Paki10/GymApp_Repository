import 'package:flutter/material.dart';

class MealItem extends StatelessWidget {
  final String name;
  final String calories;
  final String? assetPath;
  final String? p, c, f;

  const MealItem({
    super.key,
    required this.name,
    required this.calories,
    this.assetPath,
    this.p,
    this.c,
    this.f,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 55,
              height: 55,
              color: Colors.grey[200],
              child: assetPath != null
                  ? Image.asset(
                      assetPath!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    )
                  : const Icon(Icons.restaurant, color: Colors.green),
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(calories),
              if (p != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      _macroText("P: ", p!, Colors.red[700]!),
                      _macroText("C: ", c!, Colors.blue[700]!),
                      _macroText("F: ", f!, Colors.orange[700]!),
                    ],
                  ),
                ),
            ],
          ),
          trailing: const Icon(Icons.add_circle, color: Colors.blueAccent),
        ),
      ),
    );
  }

  Widget _macroText(String label, String value, Color color) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        Text("$value  ", style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
