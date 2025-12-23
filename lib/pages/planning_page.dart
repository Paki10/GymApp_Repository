import 'package:flutter/material.dart';

class PlanningPage extends StatefulWidget {
  const PlanningPage({super.key});

  @override
  State<PlanningPage> createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  int? selectedDay;

  final Map<int, String> plans = {};

  final List<String> months = const [
    "Januari",
    "Februari",
    "Maart",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Augustus",
    "September",
    "Oktober",
    "November",
    "December",
  ];

  int daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  void showPlanDialog(int day) {
    final TextEditingController controller =
        TextEditingController(text: plans[day] ?? "");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Planning $day ${months[selectedMonth - 1]} $selectedYear",
          ),
          content: TextField(
            controller: controller,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "Vul in wat je vandaag gaat doen.",
              hintText: "Elke dag een stap dichter ij je doel!",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Annuleer"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  //zorgt ervoor dat als er iets is dat het opslaagt anders word het verwijdert
                  final text = controller.text.trim();
                  if (text.isEmpty) {
                    plans.remove(day);
                    if (selectedDay == day) selectedDay = null;
                  } else {
                    plans[day] = text;
                    selectedDay = day;
                  }
                });
                Navigator.pop(context);
              },
              child: const Text("Opslaan"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final int totalDays = daysInMonth(selectedYear, selectedMonth);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      //Styling van kalender pagina https://github.com/flutter/gallery#flutter-gallery
      //flutter gebaseerd cards en kleur schemas dialogs etc: https://m3.material.io/

      body: Column(
        children: [
          // blauwe header zoals in figma
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5B6CFF), Color(0xFF7B8CFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
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
          ),

          const SizedBox(height: 16),

          // code voor kaart met kalender
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Kalender Card
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // drop down menu voor maand en jaar
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButton<int>(
                                  value: selectedMonth,
                                  underline: const SizedBox(),
                                  items: List.generate(12, (index) {
                                    return DropdownMenuItem(
                                      value: index + 1,
                                      child: Text(months[index]),
                                    );
                                  }),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedMonth = value!;
                                      selectedDay = null;
                                    });
                                  },
                                ),
                                DropdownButton<int>(
                                  value: selectedYear,
                                  underline: const SizedBox(),
                                  items: List.generate(5, (index) {
                                    final year = now.year + index;
                                    return DropdownMenuItem(
                                      value: year,
                                      child: Text(year.toString()),
                                    );
                                  }),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedYear = value!;
                                      selectedDay = null;
                                    });
                                  },
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // Weekdagen object array met dagen erin voor later drop dwn
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Ma"),
                                Text("Di"),
                                Text("Wo"),
                                Text("Do"),
                                Text("Vr"),
                                Text("Za"),
                                Text("Zo"),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // grid voor kalender
                            Expanded(
                              child: GridView.count(
                                //https://api.flutter.dev/flutter/rendering/SliverGridDelegateWithFixedCrossAxisCount/crossAxisCount.html
                                crossAxisCount: 7,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                children: List.generate(totalDays, (index) {
                                  final day = index + 1;
                                  final DateTime dayDate =
                                      DateTime(selectedYear, selectedMonth, day);

                                  final bool isPast = dayDate.isBefore(today);
                                  final bool isSelected = selectedDay == day;
                                  final bool hasPlan = plans.containsKey(day);

                                  Color color = Colors.grey.shade200;
                                  Color textColor = Colors.black;
                                  //stuk voor dagen in verleden dat niet meer worden aangepast
                                  if (isPast) {
                                    color = Colors.grey.shade200;
                                    textColor = Colors.grey;
                                  } else if (isSelected) {
                                    color = Colors.blue;
                                    textColor = Colors.white;
                                  } else if (hasPlan) {
                                    color = Colors.green.shade300;
                                    textColor = Colors.white;
                                  } else {
                                    color = Colors.grey.shade300;
                                  }

                                  return GestureDetector(
                                    onTap: isPast
                                        ? null
                                        : () {
                                            setState(() {
                                              selectedDay = day;
                                            });

                                            // als er al een plan dan  gewoon selecteren en details en delete knop word getoond
                                            // als er nog geen plan is  dan dialog openen en invullen
                                            if (!plans.containsKey(day)) {
                                              showPlanDialog(day);
                                            }
                                          },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: color,
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Details en delete
                  if (selectedDay != null && plans.containsKey(selectedDay))
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Planning op $selectedDay ${months[selectedMonth - 1]} $selectedYear",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              plans[selectedDay]!,
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.delete),
                                  label: const Text("Verwijderen"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      plans.remove(selectedDay);
                                      selectedDay = null;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
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
