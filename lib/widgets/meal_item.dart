import 'package:flutter/material.dart';

// Widget: MealItem
// Doel: Het bouwen van een visuele kaart voor een specifiek voedingsmiddel of gerecht.
// Deze widget is 'Stateless' omdat de data (naam, kcal, etc.) van buitenaf wordt meegegeven en niet verandert binnen dit scherm.
class MealItem extends StatelessWidget {
  final String name; // De naam van het gerecht
  final String calories; // De tekst voor de calorieën
  final String? assetPath; // Optioneel: Het pad naar de afbeelding in je assets
  final String? p, c, f; // Optioneel: Eiwit (P), Koolhydraten (C) en Vetten (F)

  const MealItem({
    super.key,
    required this.name,
    required this.calories,
    this.assetPath,
    this.p,
    this.c,
    this.f,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // shape: Bepaalt de vorm van de kaart. Hier gebruiken we afgeronde hoeken van 15 pixels.
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          // 1. leading: Het gedeelte aan het begin (links) van de rij.
          leading: ClipRRect(
            // ClipRRect: Snijdt de hoeken van de afbeelding bij zodat deze overeenkomen met de kaartstijl.
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 55,
              height: 55,
              color: Colors
                  .grey[200], // Achtergrondkleur als de afbeelding laadt of ontbreekt
              child: assetPath != null
                  ? Image.asset(
                      assetPath!,
                      fit: BoxFit
                          .cover, // Zorgt dat de afbeelding het hele vierkant vult
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                      ), // Icoon als het bestand niet gevonden wordt
                    )
                  : const Icon(Icons.restaurant, color: Colors.green),
            ),
          ),

          // 2. title: De hoofdtitel van de rij.
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          // 3. subtitle: De secundaire informatie onder de titel.
          subtitle: Column(
            // crossAxisAlignment.start: Zorgt dat de calorieën en macro's netjes aan de LINKERKANT beginnen.
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(calories),
              // Collection If: Alleen als 'p' (eiwit) is meegegeven, tekenen we de rij met macro-informatie.
              if (p != null)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                  ), // Kleine ruimte tussen de calorieën en de macro's
                  child: Row(
                    children: [
                      // We roepen de helper-functie _macroText aan voor een consistente stijl
                      _macroText("P: ", p!, Colors.red[700]!),
                      _macroText("C: ", c!, Colors.blue[700]!),
                      _macroText("F: ", f!, Colors.orange[700]!),
                    ],
                  ),
                ),
            ],
          ),

          // 4. trailing: Het gedeelte aan het einde (rechts) van de rij.
          trailing: const Icon(Icons.add_circle, color: Colors.blueAccent),
        ),
      ),
    );
  }

  // FUNCTIE: _macroText
  // DOEL: Een herbruikbaar tekstblokje maken voor de macro-voedingswaarden (P, C, F).
  // Waarom: Door dit in een functie te zetten, hoeven we de TextStyle en de Row niet drie keer te herhalen.
  Widget _macroText(String label, String value, Color color) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color:
                color, // Gebruikt de meegegeven kleur (bijv. rood voor eiwit)
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        // We voegen twee spaties toe na de waarde voor een mooie tussenruimte tussen P, C en F
        Text("$value  ", style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
