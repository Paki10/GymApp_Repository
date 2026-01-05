import 'package:flutter/material.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/macro_card.dart';
import '../widgets/meal_item.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  String selectedGoal = 'Maintain';

  final Map<String, Map<String, double>> macroData = {
    'Lose Weight': {'protein': 0.45, 'carbs': 0.25, 'fat': 0.30},
    'Maintain': {'protein': 0.30, 'carbs': 0.40, 'fat': 0.30},
    'Gain Weight': {'protein': 0.25, 'carbs': 0.55, 'fat': 0.20},
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nutrition'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Column(
          children: [
            // Goal Selector
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

            MacroCard(
              selectedGoal: selectedGoal,
              macros: macroData[selectedGoal]!,
            ),

            const TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.blueAccent,
              tabs: [
                Tab(text: 'Breakfast'),
                Tab(text: 'Lunch'),
                Tab(text: 'Dinner'),
              ],
            ),

            Expanded(
              child: TabBarView(
                children: [
                  _buildList([
                    const MealItem(
                      name: 'Oatmeal with banana',
                      calories: '450 kcal',
                      assetPath: "assets/HavermoutMetBanaan.png",
                      p: '12g',
                      c: '65g',
                      f: '8g',
                    ),
                    const MealItem(
                      name: 'Greek yogurt',
                      calories: '300 kcal',
                      assetPath: 'assets/GriekseYoghurt.png',
                      p: '20g',
                      c: '15g',
                      f: '10g',
                    ),
                  ]),
                  _buildList([
                    const MealItem(
                      name: 'Chicken salad',
                      calories: '550 kcal',
                      assetPath: 'assets/KipSalade.png',
                      p: '35g',
                      c: '10g',
                      f: '25g',
                    ),
                    const MealItem(
                      name: 'Tuna wrap',
                      calories: '400 kcal',
                      assetPath: 'assets/WrapTonijn.png',
                      p: '28g',
                      c: '45g',
                      f: '12g',
                    ),
                  ]),
                  _buildList([
                    const MealItem(
                      name: 'Salmon & Potatoes',
                      calories: '650 kcal',
                      assetPath: 'assets/ZalmEnAardappel.png',
                      p: '40g',
                      c: '50g',
                      f: '22g',
                    ),
                    const MealItem(
                      name: 'Pasta with minced meat',
                      calories: '700 kcal',
                      assetPath: 'assets/PastaGehakt.png',
                      p: '32g',
                      c: '85g',
                      f: '18g',
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNavigation(currentIndex: 2),
      ),
    );
  }

  Widget _goalButton(String goal, IconData icon) {
    bool isSelected = selectedGoal == goal;
    return GestureDetector(
      onTap: () => setState(() => selectedGoal = goal),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
            const SizedBox(height: 4),
            Text(
              goal,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<Widget> items) =>
      ListView(padding: const EdgeInsets.all(16.0), children: items);
}
