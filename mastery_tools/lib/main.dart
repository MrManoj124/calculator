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

class MainScreen extends StatefulWidget{
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
} 

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    const CalculatorTab(),
    const StopwatchTab(),
    const ConverterTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mastery Tools', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0ea5e9),
        foregroundColor: Colors.white,
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: const Color(0xFF2563eb),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Calculator'),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Stopwatch'),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Converter'),
        ],
      ),
    );
  }
}