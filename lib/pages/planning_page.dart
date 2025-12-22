import 'package:flutter/material.dart';

class PlanningPage  extends StatelessWidget{
  const PlanningPage({super.key});
  
    @override
    Widget build(BuildContext){
      return Scaffold(
        appBar: AppBar(
          title : const Text("Planning")),
          body: const Center(
            child: Text("Hier komen de trainningsdagen"),
          ),
        );
    }
}