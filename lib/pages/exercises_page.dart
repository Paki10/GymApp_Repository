import 'package:flutter/material.dart';

// Docs: https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html
class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  // We houden een Set bij van titels van kaarten die uitgeklapt zijn
  // Docs: https://dart.dev/guides/language/language-tour#sets
  final Set<String> _expandedCards = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Exercises',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        // Source for SingelCHildSCrollView: https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose your training program",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // 1. Chest & Triceps
            _buildWorkoutCard(
              title: 'Chest & Triceps',
              duration: '60 min',
              level: 'Intermediate',
              calories: '450 kcal',
              color: Colors.blue[600]!,
              imagePath: 'assets/chest_workout.png',
              exercises: [
                {'name': 'Bench Press', 'sets': '4x10'},
                {'name': 'Incline Dumbbell Press', 'sets': '3x12'},
                {'name': 'Cable Flys', 'sets': '3x15'},
                {'name': 'Tricep Dips', 'sets': '3x12'},
                {'name': 'Pushups', 'sets': '3xMax'},
                {'name': 'Chest Press Machine', 'sets': '3x12'},
              ],
            ),

            // 2. Back & Biceps
            _buildWorkoutCard(
              title: 'Back & Biceps',
              duration: '65 min',
              level: 'Intermediate',
              calories: '480 kcal',
              color: Colors.green[600]!,
              imagePath: 'assets/back_workout.png',
              exercises: [
                {'name': 'Pull-ups', 'sets': '4x8'},
                {'name': 'Bent Over Rows', 'sets': '4x10'},
                {'name': 'Lat Pulldown', 'sets': '3x12'},
                {'name': 'Seated Cable Row', 'sets': '3x12'},
                {'name': 'Hammer Curls', 'sets': '3x12'},
                {'name': 'Barbell Curls', 'sets': '3x10'},
              ],
            ),

            // 3. Legs, Abs & Forearms
            _buildWorkoutCard(
              title: 'Legs, Abs & Forearms',
              duration: '70 min',
              level: 'Advanced',
              calories: '600 kcal',
              color: Colors.purple[600]!,
              imagePath: 'assets/legs_workout.png',
              exercises: [
                {'name': 'Squats', 'sets': '4x10'},
                {'name': 'Leg Press', 'sets': '4x12'},
                {'name': 'Lunges', 'sets': '3x10'},
                {'name': 'Leg Curls', 'sets': '3x15'},
                {'name': 'Plank', 'sets': '3x60s'},
                {'name': 'Wrist Curls', 'sets': '3x20'},
                {'name': 'Leg Raises', 'sets': '3x15'},
              ],
            ),

            // 4. Home Training
            _buildWorkoutCard(
              title: 'Home Training',
              duration: '45 min',
              level: 'Beginner',
              calories: '300 kcal',
              color: Colors.orange[800]!,
              imagePath: 'assets/home_workout.png',
              exercises: [
                {'name': 'Push-ups', 'sets': '4x15'},
                {'name': 'Bodyweight Squats', 'sets': '4x20'},
                {'name': 'Lunges', 'sets': '3x12'},
                {'name': 'Plank', 'sets': '3x45s'},
                {'name': 'Mountain Climbers', 'sets': '3x30s'},
                {'name': 'Burpees', 'sets': '3x10'},
                {'name': 'Jumping Jacks', 'sets': '3x50'},
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutCard({
    required String title,
    required String duration,
    required String level,
    required String calories,
    required Color color,
    required String imagePath,
    required List<Map<String, String>> exercises,
  }) {
    // Check of deze kaart momenteel is uitgeklapt
    bool isExpanded = _expandedCards.contains(title);

    // Toon alle oefeningen als het is uitgeklapt, anders de eerste 4
    // Docs: https://api.flutter.dev/flutter/dart-core/Iterable/take.html
    final displayedExercises = isExpanded
        ? exercises
        : exercises.take(4).toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.fitness_center,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '$duration  •  ',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        level,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Text(
                      '  •  ${exercises.length} exercises',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Afbeelding
          SizedBox(
            height: 150,
            width: double.infinity,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.image),
              ),
            ),
          ),

          // Oefeningen Lijst
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Exercise List",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 12),
                // We mappen door de 'displayedExercises' variabele
                ...displayedExercises.asMap().entries.map((entry) {
                  int idx = entry.key + 1;
                  var ex = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.grey[100],
                              child: Text(
                                '$idx',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              ex['name']!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        Text(
                          ex['sets']!,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),

                // De interactieve knop
                if (exercises.length > 4)
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Source for setState: https://api.flutter.dev/flutter/widgets/State/setState.html
                        setState(() {
                          if (isExpanded) {
                            _expandedCards.remove(title);
                          } else {
                            _expandedCards.add(title);
                          }
                        });
                      },
                      child: Text(
                        isExpanded
                            ? "Show less"
                            : "+${exercises.length - 4} more exercises",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),

                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: Colors.orange,
                      size: 16,
                    ),
                    Text(
                      " Est. Burn: $calories",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
