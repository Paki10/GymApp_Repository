import 'package:flutter/material.dart';

class ExercisesPage extends StatelessWidget{
  const ExercisesPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Oefeningen')),
      body: const Center(child: Text('Oefeninfen pagina'),),
    );
  }
}