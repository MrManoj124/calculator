// Import the packages and libraries
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(const MasteryToolsApp());
}

class MasteryToolsApp extends StatelessWidget{
  const MasteryToolsApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'Mastery Tools',
      theme:ThemeData(
        primaryColor: const Color(0xFF0ea5e9),
        scaffoldBackgroundColor: const Color(0xFFf8fbff),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0ea5e9)),
        useMaterial3: true,
      ),
      home : const MainScreen(),
      debugShowCheckedModeBanner: false,
    ); 
  }
}