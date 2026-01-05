import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_page.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
//https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
//is eigenlijke een controller, dat de teext veld update de value telkens dat een user iets typt in de textveld. Het luistert naar de UI
//Text property gemodified -> text veld gemodified
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //Boxcontains https://api.flutter.dev/flutter/rendering/BoxConstraints-class.html
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //legale en juiste value voor beide contraints
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF7B2FF7),
              Color(0xFF4FACFE),
            ],
          ),
        ),
        child: Center(
          child: Container(
            width: 330,
            //net hetzelfde voor padding boven beneden -> overal 24
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
            //https://api.flutter.dev/flutter/rendering/MainAxisSize.html
            //indien er nog vrije ruimte is, zorgt dit ervoor om die ruimte te vergroten of te verkleinen
              mainAxisSize: MainAxisSize.min,
              children: [
                //Gebruik ik voor de foto's om ze tot in detail aan te passen
              ClipRRect(borderRadius: BorderRadius.circular(24),
              child: Image.asset('assets/GymApp_Screen.png',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                ),
              ),
              

                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              
                

                const SizedBox(height: 24),

                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: passwordController,
                  //Dit zorgt ervoor dat wat er getypt word, verstopt blijft. Dus het word niet getoond tijdens typen
                  //https://api.flutter.dev/flutter/material/TextField/obscureText.html
                  obscureText: true,
                  //designed de text field
                  //https://api.flutter.dev/flutter/material/InputDecoration-class.html
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        //Ik gebruik firebase zodat de login onthouden bkijft, ook al logt de persoon uit en sluite de aplicatie, blijft de account bestaan
                        //https://pub.dev/documentation/firebase_auth_dart/latest/
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>  HomePage(),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login failed'),
                          ),
                        );
                      }
                    },
                    child: const Text("Log in"),
                  ),
                ),

                const SizedBox(height: 16),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegisterPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Create an account",
                    style: TextStyle(
                      color: Color(0xFF7B2FF7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
