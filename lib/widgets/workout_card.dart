import 'package:flutter/material.dart';

// Widget: WorkoutCard
// Doel: Een herbruikbare kaart die informatie toont over een trainingssessie.
// Deze widget is 'Stateful' omdat we de status van het uitklappen (open/dicht) moeten bijhouden.
class WorkoutCard extends StatefulWidget {
  final String title;
  final String duration;
  final String level;
  final String calories;
  final Color color;
  final String imagePath;
  final List<Map<String, String>> exercises;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.duration,
    required this.level,
    required this.calories,
    required this.color,
    required this.imagePath,
    required this.exercises,
  });

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  // Variabele: isExpanded
  // Doel: Onthouden of de gebruiker op 'more exercises' heeft geklikt.
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Logica: displayedExercises
    // Doel: Als isExpanded 'true' is, tonen we de hele lijst.
    // Zo niet, pakken we met .take(4) alleen de eerste vier oefeningen.
    final displayedExercises = isExpanded
        ? widget.exercises
        : widget.exercises.take(4).toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 24), // Ruimte onder de kaart
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          20,
        ), // Maakt de hoeken van de kaart rond
        boxShadow: [
          // Voegt een subtiele schaduw toe voor een modern 'floating' effect
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // 1. De Header (Gekleurde bovenkant)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(
                  20,
                ), // Zorgt dat alleen de bovenhoeken rond zijn
              ),
            ),
            child: _buildHeader(),
          ),

          // 2. De Afbeelding
          // Gebruik van SizedBox om de afbeelding een vaste hoogte te geven.
          SizedBox(
            height: 150,
            width:
                double.infinity, // Neemt de volledige breedte van de kaart in
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit
                  .cover, // Zorgt dat de foto de ruimte vult zonder te vervormen
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Icon(
                  Icons.image,
                ), // Toont een icoon als de foto niet laadt
              ),
            ),
          ),

          // 3. De Lijst met Oefeningen
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              // crossAxisAlignment.start: Lijnt alle teksten en rijen uit aan de LINKERKANT.
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Exercise List",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 12),

                // Spread operator (...): Voegt de lijst met rijen direct toe aan de Column.
                ...displayedExercises
                    .asMap()
                    .entries
                    .map(
                      (entry) => _buildExerciseRow(entry.key + 1, entry.value),
                    )
                    .toList(),

                // Toont de knop alleen als er daadwerkelijk meer dan 4 oefeningen zijn.
                if (widget.exercises.length > 4) _buildExpandButton(),

                const Divider(), // Een horizontale lijn ter scheiding
                _buildCalorieFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Functie: _buildHeader
  // Doel: De bovenste rij bouwen met het icoon, de titel en de algemene info.
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // mainAxisAlignment.spaceBetween: Zet de titel links en het pijltje helemaal rechts.
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.fitness_center, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '${widget.duration}  •  ${widget.level}  •  ${widget.exercises.length} exercises',
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  // Functie: _buildExerciseRow
  // Doel: Een enkele rij maken voor een oefening met nummer, naam en sets.
  Widget _buildExerciseRow(int index, Map<String, String> exercise) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // CircleAvatar: Maakt een mooi klein rondje voor het nummer.
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.grey[100],
                child: Text(
                  '$index',
                  style: const TextStyle(fontSize: 10, color: Colors.black),
                ),
              ),
              const SizedBox(width: 12),
              Text(exercise['name']!, style: const TextStyle(fontSize: 14)),
            ],
          ),
          Text(
            exercise['sets']!,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Functie: _buildExpandButton
  // Doel: De knop die de 'isExpanded' status omdraait.
  Widget _buildExpandButton() {
    return Center(
      child: TextButton(
        // setState: Vertelt Flutter dat de data veranderd is en het scherm ververst moet worden.
        onPressed: () => setState(() => isExpanded = !isExpanded),
        child: Text(
          // Ternary operator: Wisselt tekst op basis van de status van 'isExpanded'.
          isExpanded
              ? "Show less"
              : "+${widget.exercises.length - 4} more exercises",
          style: const TextStyle(color: Colors.blue, fontSize: 12),
        ),
      ),
    );
  }

  // Functie: _buildCalorieFooter
  // Doel: De onderste regel met het vuur-icoon en de calorieverbranding.
  Widget _buildCalorieFooter() {
    return Row(
      // mainAxisAlignment.center: Zet het icoon en de tekst in het MIDDEN van de rij.
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.local_fire_department, color: Colors.orange, size: 16),
        Text(
          " Est. Burn: ${widget.calories}",
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
