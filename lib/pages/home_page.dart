import 'package:flutter/material.dart';

// Widgets
import '../widgets/home_calendar.dart';
import '../widgets/home_exercises.dart';
import '../widgets/home_nutrition.dart';
import '../widgets/plan_dialog.dart';
import '../widgets/menu_dropdown.dart'; //

// Pages
import 'exercises_page.dart';
import 'nutrition_page.dart';
import 'settings_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Ale data dat ik nodig heb vooraleer we beginnen
  //Ik maak hier een lijst van object array's aan, voor de exercises en nutrition te tonen op het scherm.
  //Elk object bevat informatie, zoals titel afbeeldingen enz
  //final = const in flutter -> kan niet meer aangepast worden
  final List<Map<String, String>> exercises = const [
    {
      'title': 'Push-ups',
      'info': '15 min • 120 cal',
      'image': 'assets/chest_workout.png',
    },
    {
      'title': 'Squats',
      'info': '20 min • 180 cal',
      'image': 'assets/legs_workout.png',
    },
  ];

  final List<Map<String, String>> nutritions = const [
    {
      'title': 'Greek Yogurt',
      'image': 'assets/GriekseYoghurt.png',
    },
    {
      'title': 'Oatmeal',
      'image': 'assets/HavermoutMetBanaan.png',
    },
    {
      'title': 'Pasta',
      'image': 'assets/PastaGehakt.png',
    },
    {
      'title': 'Salmon Bowl',
      'image': 'assets/ZalmEnAardappel.png',
    },
  ];

  // planning per dag (training + tijd + eten)
  final Map<int, Map<String, String>> plans = {};

  // geselecteerde dag in de kalender
  //Je kan ook 0 zetten, maar dit is minder duidelijk
  int selectedDay = -1;

  //De BuildContext build-methode die tekent of zeg maar maakt de volledige UI Pagina
  //ik geef hier dus de datum en tijd weer, voor de making van de calender
  //Scaffold, kan je vergelijken met de basis, waaronder alles komt zoals appbar, body etc)
  //via route navigeer ik tussen de pagina's bij het klikken van een ikoontje vb
  @override
  //Ik haal de datum op, vervolgens laat ik de tijd weg zodat ik alleen nog de datum heb.
  
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    int month = now.month;
    int year = now.year;
    //Berekening voor de juiste datum te krijgen 1 = volgende maand, 0 = laatste datum ervan
    int daysInMonth = DateTime(year, month + 1, 0).day;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      // App Bar
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A7CFF),
        elevation: 0,

        // Profiel
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              //https://www.youtube.com/watch?v=j1qA973hsx0
              //yt video die me meer uitlegde over het navigeren tussen mde pagina"s
              MaterialPageRoute(builder: (_) => ProfilePage()),
            );
          },
        ),

        // Dropdown (nu aparte widget)
        actions: [
          MenuDropdown(
            onSelected: (value) {
              if (value == 'home') return;

              if (value == 'workouts') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ExercisesPage()),
                );
              }

              if (value == 'nutrition') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NutritionPage()),
                );
              }

              if (value == 'settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              }
            },
          ),
        ],
      ),

      // Body
      //in mijn body, maak ik de lay-out van mijn methodes, zoals calender, hier zorg ik hoe het er uit moet zien
      // Je kan het vergelijken met de CSS van een programma
      //Dit ook voor al de rest, zoals exercises, nutrition enz...
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Calender
            HomeCalendar(
              today: today,
              selectedDay: selectedDay,
              month: month,
              year: year,
              daysInMonth: daysInMonth,
              onDayTap: (day) {
                // wanneer je op een dag klikt, slaan we die op
                setState(() {
                  selectedDay = day;
                });

                // hier openen we de popup om een planning toe te voegen
                _showPlanDialog(day, month, year);
              },
            ),

            // Exercises
            HomeExercises(exercises: exercises),

            const SizedBox(height: 32),

            // Nutrition
            HomeNutrition(nutritions: nutritions),

            const SizedBox(height: 32),
          ],
        ),
      ),

      // Bottom Navigatie
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        //Blauw
        selectedItemColor: const Color(0xFF6A7CFF),
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ExercisesPage()),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NutritionPage()),
            );
          }
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsPage()),
            );
          }
        },
        //Icons gevonden https://fonts.google.com/icons
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: 'Workouts'),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant), label: 'Nutrition'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
  //Pop up dialog
  // popup tonen om een planning toe te voegen of aan te passen
  void _showPlanDialog(int day, int month, int year) {
    final DateTime selectedDate = DateTime(year, month, day);

    // controleren of er al een planning bestaat voor deze dag
    VoidCallback? onDelete;
    //Delete functie geldig alleen als de plans niet leeg is
    if (plans.containsKey(day)) {
      onDelete = () {
        setState(() {
          plans.remove(day);
        });
      };
    }

    showDialog(
      context: context,
      builder: (_) => PlanningDialog(
        date: selectedDate,
        existingPlan: plans[day],
        onSave: (data) {
          setState(() {
            plans[day] = data;
          });
        },
        onDelete: onDelete,
      ),
    );
  }
}
