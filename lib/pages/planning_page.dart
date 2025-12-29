import 'package:flutter/material.dart';
import '../widgets/planning_header.dart';
import '../widgets/calendar_grid.dart';
import '../widgets/plan_details_card.dart';

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

  final List<String> months = [
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
    TextEditingController controller =
        TextEditingController(text: plans[day] ?? "");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              Text("Planning $day ${months[selectedMonth - 1]} $selectedYear"),
          content: TextField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: "Vul in wat je vandaag gaat doen",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Annuleer"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  String text = controller.text.trim();
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
              child: Text("Opslaan"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    int totalDays = daysInMonth(selectedYear, selectedMonth);

    return Scaffold(
      backgroundColor: Color(0xFFF4F6FA),

      // AppBar is nodig voor het terug pijltje
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(''),
      ),

      body: Column(
        children: [
          // blauwe header van de planning pagina
          PlanningHeader(),
          SizedBox(height: 16),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // Maand & jaar dropdowns
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButton<int>(
                                  value: selectedMonth,
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
                                  items: List.generate(5, (index) {
                                    int year = now.year + index;
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

                            SizedBox(height: 12),

                            // Weekdagen
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Ma"),
                                Text("Di"),
                                Text("Wo"),
                                Text("Do"),
                                Text("Vr"),
                                Text("Za"),
                                Text("Zo"),
                              ],
                            ),

                            SizedBox(height: 12),

                            // Kalender grid (widget)
                            Expanded(
                              child: CalendarGrid(
                                totalDays: totalDays,
                                selectedDay: selectedDay ?? -1,
                                today: today,
                                month: selectedMonth,
                                year: selectedYear,
                                plans: plans,
                                onDayTap: (day) {
                                  setState(() {
                                    selectedDay = day;
                                  });

                                  if (!plans.containsKey(day)) {
                                    showPlanDialog(day);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 12),

                  // Details van de planning + delete knop
                  if (selectedDay != null &&
                      plans.containsKey(selectedDay))
                    PlanDetailsCard(
                      day: selectedDay!,
                      month: months[selectedMonth - 1],
                      year: selectedYear,
                      text: plans[selectedDay!]!,
                      onDelete: () {
                        setState(() {
                          plans.remove(selectedDay);
                          selectedDay = null;
                        });
                      },
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
