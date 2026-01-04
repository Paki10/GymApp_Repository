import 'package:flutter/material.dart';
import 'package:gym_app1/widgets/app_bottom_navigation.dart';
class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  // Keeping track of the selected goal
  String selectedGoal = 'Maintain';

  // Macro data per goal (Protein %, Carbohydrates %, Fat %)
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
            // 1. Goal Selector
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

            // 2. Macro Distribution Card
            _buildMacroCard(),

            // 3. TabBar for meal moments
            const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blueAccent,
              tabs: [
                Tab(text: 'Breakfast'),
                Tab(text: 'Lunch'),
                Tab(text: 'Dinner'),
              ],
            ),

            // 4. List of meals
            Expanded(
              child: TabBarView(
                children: [
                  // Section 1: Breakfast
                  _buildMealList([
                    _mealItem(
                      'Oatmeal with banana',
                      '450 kcal',
                      assetPath: "assets/HavermoutMetBanaan.png",
                      p: '12g',
                      c: '65g',
                      f: '8g',
                    ),
                    _mealItem(
                      'Greek yogurt',
                      '300 kcal',
                      assetPath: 'assets/GriekseYoghurt.png',
                      p: '20g',
                      c: '15g',
                      f: '10g',
                    ),
                  ]),
                  // Section 2: Lunch
                  _buildMealList([
                    _mealItem(
                      'Chicken salad',
                      '550 kcal',
                      assetPath: 'assets/KipSalade.png',
                      p: '35g',
                      c: '10g',
                      f: '25g',
                    ),
                    _mealItem(
                      'Tuna wrap',
                      '400 kcal',
                      assetPath: 'assets/WrapTonijn.png',
                      p: '28g',
                      c: '45g',
                      f: '12g',
                    ),
                  ]),
                  // Section 3: Dinner
                  _buildMealList([
                    _mealItem(
                      'Salmon & Potatoes',
                      '650 kcal',
                      assetPath: 'assets/ZalmEnAardappel.png',
                      p: '40g',
                      c: '50g',
                      f: '22g',
                    ),
                    _mealItem(
                      'Pasta with minced meat',
                      '700 kcal',
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

  // --- UI HELPERS ---

  Widget _goalButton(String goal, IconData icon) {
    bool isSelected = selectedGoal == goal;
    return GestureDetector(
      // Source for GestureDetector: https://api.flutter.dev/flutter/widgets/GestureDetector-class.html
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
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroCard() {
    var macros = macroData[selectedGoal]!;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Macro Distribution for $selectedGoal",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _macroBar("Protein", macros['protein']!, Colors.red),
          _macroBar("Carbohydrates", macros['carbs']!, Colors.blue),
          _macroBar("Fat", macros['fat']!, Colors.orange),
        ],
      ),
    );
  }

  Widget _macroBar(String label, double percent, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment
            .start, // Source for CrossAxisAlignment: https://api.flutter.dev/flutter/rendering/CrossAxisAlignment.html
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 12)),
              Text("${(percent * 100).toInt()}%"),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            // Source for LinearProgressIndicator: https://api.flutter.dev/flutter/material/LinearProgressIndicator-class.html
            value: percent,
            backgroundColor: Colors.grey[200],
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildMealList(List<Widget> items) {
    return ListView(padding: const EdgeInsets.all(16.0), children: items);
  }

  Widget _mealItem(
    String name,
    String calories, {
    IconData? icon,
    String? assetPath,
    String? p,
    String? c,
    String? f,
  }) {
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
                      assetPath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    )
                  : Icon(icon ?? Icons.restaurant, color: Colors.green),
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
                      Text(
                        "P: ",
                        style: TextStyle(
                          color: Colors.red[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text("$p  ", style: const TextStyle(fontSize: 12)),
                      Text(
                        "C: ",
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text("$c  ", style: const TextStyle(fontSize: 12)),
                      Text(
                        "F: ",
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text("$f", style: const TextStyle(fontSize: 12)),
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
}
