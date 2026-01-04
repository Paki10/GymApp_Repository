import 'package:flutter/material.dart';
import 'calendar_grid.dart';

class HomeCalendar extends StatelessWidget {
  final DateTime today;
  final int selectedDay;
  final int month;
  final int year;
  final int daysInMonth;
  final Function(int) onDayTap;

  const HomeCalendar({
    super.key,
    required this.today,
    required this.selectedDay,
    required this.month,
    required this.year,
    required this.daysInMonth,
    required this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titel boven de kalender
          const Text(
            'Calendar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // Styling voor de maand en jaar
                  Text(
                    '${_monthName(month)} $year',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Weekdagen
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mo'),
                      Text('Tu'),
                      Text('We'),
                      Text('Th'),
                      Text('Fr'),
                      Text('Sa'),
                      Text('Su'),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Kalender grid
                  SizedBox(
                    height: 240,
                    child: CalendarGrid(
                      totalDays: daysInMonth,
                      selectedDay: selectedDay,
                      today: today,
                      month: month,
                      year: year,
                      plans: const {},
                      onDayTap: onDayTap,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Maand namen
String _monthName(int monthNumber) {
  const months = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  return months[monthNumber];
}
