import 'package:flutter/material.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/workout_card.dart';

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold is het 'geraamte' van je pagina (appbar boven, body in het midden, menu onder).
    return Scaffold(
      backgroundColor:
          Colors.grey[100], // De achtergrondkleur van de hele pagina.
      appBar: AppBar(
        title: const Text(
          'Exercises',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent, // Maakt de balk doorzichtig.
        elevation: 0, // Verwijdert de schaduw onder de bovenbalk.
        centerTitle:
            false, // Zet de titel aan de linkerkant (vaker op iOS/Android apps).
      ),
      // SingleChildScrollView zorgt ervoor dat je omlaag kunt scrollen als de lijst te lang is.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          16.0,
        ), // Geeft een beetje ademruimte aan de zijkanten.
        // Column zet alle elementen (tekst, kaartjes) onder elkaar.
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Zorgt dat alle tekst links begint.
          children: [
            const Text(
              "Choose your training program",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ), // Een onzichtbaar blokje om witruimte te maken.
            // Hieronder roep je 4x de 'WorkoutCard' aan.

            // 1. Chest & Triceps Card
            const WorkoutCard(
              title: 'Chest & Triceps', // Naam van de workout.
              duration: '60 min', // Tijd.
              level: 'Intermediate', // Moeilijkheidsgraad.
              calories: '450 kcal', // Geschatte calorieën.
              color: Color(0xFF1E88E5), // De specifieke kleur van het kaartje.
              imagePath:
                  'assets/chest_workout.png', // Het plaatje dat erbij hoort.
              // 'exercises' is een lijst (List) van kleine stukjes info (Maps) met oefeningen.
              exercises: [
                {'name': 'Bench Press', 'sets': '4x10'},
                {'name': 'Incline Dumbbell Press', 'sets': '3x12'},
                {'name': 'Cable Flys', 'sets': '3x15'},
                {'name': 'Tricep Dips', 'sets': '3x12'},
                {'name': 'Pushups', 'sets': '3xMax'},
                {'name': 'Chest Press Machine', 'sets': '3x12'},
              ],
            ),

            // 2. Back & Biceps Card (Zelfde opbouw als hierboven)
            const WorkoutCard(
              title: 'Back & Biceps',
              duration: '65 min',
              level: 'Intermediate',
              calories: '480 kcal',
              color: Color(0xFF43A047),
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

            // 3. Legs, Abs & Forearms Card (Zelfde opbouw)
            const WorkoutCard(
              title: 'Legs, Abs & Forearms',
              duration: '70 min',
              level: 'Advanced',
              calories: '600 kcal',
              color: Color(0xFF8E24AA),
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

            // 4. Home Training Card (Zelfde opbouw)
            const WorkoutCard(
              title: 'Home Training',
              duration: '45 min',
              level: 'Beginner',
              calories: '300 kcal',
              color: Color(0xFFE65100),
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
      // Roept de navigatiebalk aan. Index 1 betekent dat het tweede icoontje actief is.
      bottomNavigationBar: AppBottomNavigation(currentIndex: 1),
    );
  }
}
