import 'package:flutter/material.dart';

class CalendarGrid extends StatelessWidget {
  final int totalDays;
  final int selectedDay;
  final DateTime today;
  final int month;
  final int year;
  final Map<int, String> plans;
  final Function(int) onDayTap;

  const CalendarGrid({
    super.key,
    required this.totalDays,
    required this.selectedDay,
    required this.today,
    required this.month,
    required this.year,
    required this.plans,
    required this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 7,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: List.generate(totalDays, (index) {
        int day = index + 1;
        DateTime date = DateTime(year, month, day);

        bool isPast = date.isBefore(today);
        bool isSelected = selectedDay == day;
        bool hasPlan = plans.containsKey(day);

        Color backgroundColor = Colors.grey.shade300;
        Color textColor = Colors.black;

        if (isPast) {
          backgroundColor = Colors.grey.shade200;
          textColor = Colors.grey;
        } else if (isSelected) {
          backgroundColor = Colors.blue;
          textColor = Colors.white;
        } else if (hasPlan) {
          backgroundColor = Colors.green.shade300;
          textColor = Colors.white;
        }

        return GestureDetector(
          onTap: isPast ? null : () => onDayTap(day),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              day.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        );
      }),
    );
  }
}
