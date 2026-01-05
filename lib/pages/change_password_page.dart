import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//info https://dart.dev/language/classes
//https://dart.dev/language/functions
class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: currentPasswordController,
              //https://api.flutter.dev/flutter/material/TextField/obscureText.html
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Current password',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New password',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                // validatie om te checken of dat alles goed is ingevuld
                if (currentPasswordController.text.isEmpty ||
                    newPasswordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all fields'),
                    ),
                  );
                  return;
                }

                try {
                  // huidige gebruiker ophalen, zodat firebase weet over welke gebruiker het gaat
                  final user = FirebaseAuth.instance.currentUser;
                  if (user == null) {
                    throw FirebaseAuthException(
                      code: 'no-user',
                      message: 'No user logged in',
                    );
                  }

                  final email = user.email!;
                  
                  // credential maken met huidig wachtwoord, ook voor firebase
                  final credential = EmailAuthProvider.credential(
                    email: email,
                    password: currentPasswordController.text,
                  );

                  //verplicht bij gevoelige acties
                  await user.reauthenticateWithCredential(credential);

                  // nieuw wachtwoord instellen
                  await user.updatePassword(
                    newPasswordController.text,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password updated successfully'),
                    ),
                  );

                  // terug naar vorige pagina
                  Navigator.pop(context);
                } on FirebaseAuthException catch (e) {
                  // duidelijke foutmeldingen
                  String message = 'Password change failed';

                  if (e.code == 'wrong-password') {
                    message = 'Current password is incorrect';
                  } else if (e.code == 'weak-password') {
                    message = 'New password is too weak';
                  } else if (e.code == 'requires-recent-login') {
                    message =
                        'Please log in again before changing your password';
                  }

                  // debug tester
                  debugPrint('FirebaseAuth error: ${e.code}');
                  debugPrint('FirebaseAuth message: ${e.message}');

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                } catch (e) {
                  // fallback voor onverwachte fouten
                  debugPrint('Unknown error: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Something went wrong'),
                    ),
                  );
                }
              },
              child: const Text('Save new password'),
            ),
          ],
        ),
      ),
    );
  }
}
