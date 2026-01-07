import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;

  // controllers voor extra profielinfo
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  String selectedGender = 'Male';
   @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      ageController.text = prefs.getString('age') ?? '';
      weightController.text = prefs.getString('weight') ?? '';
      birthDateController.text = prefs.getString('birthDate') ?? '';
      selectedGender = prefs.getString('gender') ?? 'Male';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // naam
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(user?.displayName ?? 'No name'),
            ),

            const Divider(),

            // email
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: Text(user?.email ?? 'No email available'),
            ),

            const Divider(),

            const SizedBox(height: 16),

            // leeftijd
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
                prefixIcon: Icon(Icons.cake),
              ),
            ),

            const SizedBox(height: 16),

            // gewicht
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                prefixIcon: Icon(Icons.monitor_weight),
              ),
            ),

            const SizedBox(height: 16),

            // Geboortedatum
            TextField(
              controller: birthDateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Birth date',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  setState(() {
                    birthDateController.text =
                        '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                  });
                }
              },
            ),

            const SizedBox(height: 16),

            // creatie geslacht
            DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: const InputDecoration(
                labelText: 'Gender',
                prefixIcon: Icon(Icons.person_outline),
              ),
              items: const [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),

            const SizedBox(height: 32),

            // slaat de informatie op, ik ben hier niet verder op ingegaan, omdat ik firestore nodig zou hebben, en mijn dependency's wilden niet werken, wanneer ik het wilde toevoegen.
            //Firebase werkt alleen met userID en user info 
            //Firestore werkt met alternatieve info
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('age', ageController.text);
                await prefs.setString('weight', weightController.text);
                await prefs.setString('birthDate', birthDateController.text);
                await prefs.setString('gender', selectedGender);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile updated'),
                  ),
                );
              },
              child: const Text('Save changes'),
            ),
          ],
        ),
      ),
    );
  }
}
