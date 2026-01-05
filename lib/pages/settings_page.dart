import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_app1/pages/change_password_page.dart';
import 'package:gym_app1/pages/profile_page.dart';
import 'login_page.dart';
import 'package:gym_app1/pages/support_email_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = false;

  // taal die geselecteerd is
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //account gedeelte in settings pagina
            const Text(
              'Account',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              subtitle: const Text('View personal information'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProfilePage()),
                );
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change password'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ChangePasswordPage()),
                );
              },
            ),

            const SizedBox(height: 24),

            // applicatie settings dus hoofd settings in settings pagina
            const Text(
              'App Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            SwitchListTile(
              secondary: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              subtitle: const Text('Workout reminders'),
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),

            const Divider(),

            // taal kiezen
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              subtitle: Text(selectedLanguage),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: const Text('Choose language'),
                      children: [
                        SimpleDialogOption(
                          child: const Text('English'),
                          onPressed: () {
                            setState(() {
                              selectedLanguage = 'English';
                            });
                            Navigator.pop(context);
                          },
                        ),
                        SimpleDialogOption(
                          child: const Text('Nederlands'),
                          onPressed: () {
                            setState(() {
                              selectedLanguage = 'Nederlands';
                            });
                            Navigator.pop(context);
                          },
                        ),
                        SimpleDialogOption(
                          child: const Text('Français'),
                          onPressed: () {
                            setState(() {
                              selectedLanguage = 'Français';
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 24),

            // De support gedeelte
            const Text(
              'Support',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // info aanvraag via mail
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Info request'),
              subtitle: const Text('Send us an email'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SupportEmailPage(
                      title: 'Info Request',
                      defaultSubject: 'Gym App Info Request',
                    ),
                  ),
                );
              },
            ),

            const Divider(),

            const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('App version'),
              subtitle: Text('1.0.0'),
            ),

            const Spacer(),

            // ===== LOGOUT =====
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
