import 'package:flutter/material.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/macro_card.dart';
import '../widgets/meal_item.dart';

// StatefulWidget: Deze pagina kan WEL veranderen terwijl de gebruiker kijkt.
// Dit is nodig omdat de macro-grafiek verandert als je op een ander doel klikt.
class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  // Variabele die bijhoudt welk doel momenteel is geselecteerd.
  String selectedGoal = 'Maintain';

  // Een Map (opslag) met de verhoudingen voor proteïne, koolhydraten en vet.
  // Dit is de 'logica' van je app: elk doel heeft zijn eigen percentages.
  final Map<String, Map<String, double>> macroData = {
    'Lose Weight': {'protein': 0.45, 'carbs': 0.25, 'fat': 0.30},
    'Maintain': {'protein': 0.30, 'carbs': 0.40, 'fat': 0.30},
    'Gain Weight': {'protein': 0.25, 'carbs': 0.55, 'fat': 0.20},
  };

  @override
  Widget build(BuildContext context) {
    // DefaultTabController beheert de tabbladen (Breakfast, Lunch, Dinner).
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: const Text('Nutrition')),
        body: Column(
          children: [
            // Goal Selector: De drie knoppen bovenaan de pagina.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _goalButton('Lose Weight', Icons.trending_down),
                  _goalButton('Maintain', Icons.remove),
                  _goalButton('Gain Weight', Icons.trending_up),
                ],
              ),
            ),

            // MacroCard: Dit component tekent de grafiek of balken.
            // Je geeft het geselecteerde doel en de bijbehorende cijfers door.
            MacroCard(
              selectedGoal: selectedGoal,
              macros:
                  macroData[selectedGoal]!, // De '!' zegt: ik weet zeker dat dit doel bestaat.
            ),

            // TabBar: De klikbare tekstjes voor de verschillende maaltijden.
            const TabBar(
              tabs: [
                Tab(text: 'Breakfast'),
                Tab(text: 'Lunch'),
                Tab(text: 'Dinner'),
              ],
            ),

            // TabBarView: De inhoud die je ziet per tabblad.
            Expanded(
              child: TabBarView(
                children: [
                  _buildList([
                    // Ontbijt lijst
                    const MealItem(
                      name: 'Oatmeal with banana',
                      calories: '450 kcal',
                      p: '12g',
                      c: '65g',
                      f: '8g',
                    ),
                    const MealItem(
                      name: 'Greek yogurt',
                      calories: '300 kcal',
                      p: '20g',
                      c: '15g',
                      f: '10g',
                    ),
                  ]),
                  _buildList([
                    // Lunch lijst
                    const MealItem(
                      name: 'Chicken salad',
                      calories: '550 kcal',
                      p: '35g',
                      c: '10g',
                      f: '25g',
                    ),
                  ]),
                  _buildList([
                    // Diner lijst
                    const MealItem(
                      name: 'Salmon & Potatoes',
                      calories: '650 kcal',
                      p: '40g',
                      c: '50g',
                      f: '22g',
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNavigation(
          currentIndex: 2,
        ), // Index 2 is het derde menu-item.
      ),
    );
  }

  // _goalButton is een 'helper functie' om de drie doelknoppen te maken zonder code te herhalen.
  Widget _goalButton(String goal, IconData icon) {
    bool isSelected =
        selectedGoal ==
        goal; // Checkt of deze knop degene is waarop geklikt is.
    return GestureDetector(
      // setState() is de belangrijkste functie: het zegt tegen Flutter "er is iets veranderd, teken de pagina opnieuw!"
      onTap: () => setState(() => selectedGoal = goal),
      child: Container(
        // Opmaak van de knop (kleur verandert als isSelected waar is).
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
            Text(goal),
          ],
        ),
      ),
    );
  }

  // Helper om snel een scrollbare lijst met maaltijden te maken.
  Widget _buildList(List<Widget> items) =>
      ListView(padding: const EdgeInsets.all(16.0), children: items);
}
