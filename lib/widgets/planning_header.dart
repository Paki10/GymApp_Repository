import 'package:flutter/material.dart';

class PlanningHeader extends StatelessWidget {
  const PlanningHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 48, 16, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF5B6CFF),
            Color(0xFF7B8CFF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.fitness_center,
              color: Color(0xFF5B6CFF),
            ),
          ),
          SizedBox(height: 12),
          Text(
            "Planning",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
