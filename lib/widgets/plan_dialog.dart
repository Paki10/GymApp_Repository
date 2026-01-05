import 'package:flutter/material.dart';

class PlanningDialog extends StatelessWidget {
  final DateTime date;
  final Map<String, String>? existingPlan;
  final Function(Map<String, String>) onSave;
  final VoidCallback? onDelete;

  const PlanningDialog({
    super.key,
    required this.date,
    this.existingPlan,
    required this.onSave,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController workoutCtrl =
        TextEditingController(text: existingPlan?['workout'] ?? '');
    final TextEditingController timeCtrl =
        TextEditingController(text: existingPlan?['time'] ?? '');
    final TextEditingController foodCtrl =
        TextEditingController(text: existingPlan?['food'] ?? '');

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Training planning',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '${date.day}-${date.month}-${date.year}',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: workoutCtrl,
              decoration: const InputDecoration(
                labelText: 'Workout',
                prefixIcon: Icon(Icons.fitness_center),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: timeCtrl,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Time',
                prefixIcon: Icon(Icons.access_time),
              ),
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (picked != null) {
                  timeCtrl.text =
                      '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                }
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: foodCtrl,
              decoration: const InputDecoration(
                labelText: 'Food after training',
                prefixIcon: Icon(Icons.restaurant),
              ),
            ),
          ],
        ),
      ),
      actions: [
        // DELETE knop alleen tonen als er al een planning bestaat
        if (existingPlan != null && onDelete != null)
          TextButton(
            onPressed: () {
              onDelete!();
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),

        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: () {
            if (workoutCtrl.text.isEmpty ||
                timeCtrl.text.isEmpty ||
                foodCtrl.text.isEmpty) {
              return;
            }

            onSave({
              'workout': workoutCtrl.text,
              'time': timeCtrl.text,
              'food': foodCtrl.text,
            });

            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
