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


// 01.Create Calculator tab
class CalculatorTab extends StatefulWidget{
  const CalculatorTab({super.key});

  @override
  State<CalculatorTab> createState() => _CalculatorTabState();
}

class _CalculatorTabState extends State<CalculatorTab>{
  String _expression = '';
  String _display = '0';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'AC') {
        _expression = '';
        _display = '0';
      } else if (value == 'DEL') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
          _display = _expression.isEmpty ? '0' : _expression;
        }
      } else if (value == '=') {
        _evaluateExpression();
      } else if (value == 'x^2') {
        if (_expression.isNotEmpty) {
          _expression = '($_expression)^2';
          _display = _expression;
        }
      } else {
        _expression += value;
        _display = _expression;
      }
    });
  }

  void _evaluateExpression() {
    try {
      String evalStr = _expression
          .replaceAll('pi', '3.14159265359')
          .replaceAll('e', '2.71828182846')
          .replaceAll('sqrt(', 'sqrt(');
      
      Parser p = Parser();
      Expression exp = p.parse(evalStr);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      
      setState(() {
        _display = eval.toStringAsFixed(6).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
        _expression = _display;
      });
    } catch (e) {
      setState(() {
        _display = 'Error';
        _expression = '';
      });
    }
  }

  Widget _buildButton(String text, {Color? bgColor, Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? Colors.white,
          foregroundColor: textColor ?? Colors.black87,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 1,
        ),
        onPressed: () => _onButtonPressed(text),
        child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            _display,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
            maxLines: 1,
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 4,
            padding: const EdgeInsets.all(10),
            children: [
              _buildButton('AC', bgColor: Colors.orange.shade50),
              _buildButton('DEL', bgColor: Colors.orange.shade50),
              _buildButton('('), _buildButton(')'),
              _buildButton('sin(', bgColor: Colors.blue.shade50),
              _buildButton('cos(', bgColor: Colors.blue.shade50),
              _buildButton('tan(', bgColor: Colors.blue.shade50),
              _buildButton('/', bgColor: Colors.blue.shade100, textColor: Colors.blue.shade900),
              _buildButton('7'), _buildButton('8'), _buildButton('9'),
              _buildButton('*', bgColor: Colors.blue.shade100, textColor: Colors.blue.shade900),
              _buildButton('4'), _buildButton('5'), _buildButton('6'),
              _buildButton('-', bgColor: Colors.blue.shade100, textColor: Colors.blue.shade900),
              _buildButton('1'), _buildButton('2'), _buildButton('3'),
              _buildButton('+', bgColor: Colors.blue.shade100, textColor: Colors.blue.shade900),
              _buildButton('log(', bgColor: Colors.blue.shade50),
              _buildButton('ln(', bgColor: Colors.blue.shade50),
              _buildButton('sqrt(', bgColor: Colors.blue.shade50),
              _buildButton('x^2', bgColor: Colors.blue.shade50),
              _buildButton('pi', bgColor: Colors.blue.shade50),
              _buildButton('e', bgColor: Colors.blue.shade50),
              _buildButton('.'),
              _buildButton('=', bgColor: const Color(0xFF0ea5e9), textColor: Colors.white),
            ],
          ),
        ),
      ],
    );
  }
}


// 2. StopWatch Tab
class StopWatchTab extends StatefulWidget{
  const StopWatchTab({super.key});

  @override
  State<StopwatchTab> createState() => _StopWatchTabState();
}

class _StopWatchTabState extends State<StopWatchtab>{
  final StopWatch _stopwatch = Stopwatch();
  Timer? _timer;
  final List<String> _laps = [];

  void _startTimer(){
    if(!_stopwatch.isRunning){
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 30), (timer){
        setState(() {});
      });
    }
  }

  void _pauseTimer(){
    _stopwatch.stop();
    _timer?.cancel();
    setState(() {});
    }

  void _resetTimer(){
    _stopwatch.reset();
    _stopwatch.stop();
    _timer?.cancel();
    setState(() {
      _laps.clear();
    });
  }

  void _recordLap(){
    if(_stopwatch.isRunning){
      setState(() {
        _laps.insert(0, _formattedTime());
      });
    }
  }

  String _formattedTime(){
    final int milli = _stopwatch.elapsedMilliseconds;
    final int centi = (milli % 1000) ~/ 10;
    final int sec = (milli ~/ 1000) % 60;
    final int min = (milli ~/ 60000) % 60;
    final int hr = milli ~/ 3600000;
    return '${hr.toString().padLeft(2, '0')} : ${min.toString().padLeft(2, '0')} : ${sec.toString().padLeft(2, '0')}.${centi.toString().padLeft(2, '0')}';
  }

  @override 
  void dispose(){
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Text(
          _formattedTime(),
          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, fontFeatures: [FontFeature.tabularFigures()]),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: _startTimer, child: const Text('Start')),
            ElevatedButton(onPressed: _pauseTimer, child: const Text('Pause')),
            ElevatedButton(onPressed: _resetTimer, child: const Text('Reset')),
            ElevatedButton(onPressed: _recordLap, child: const Text('Lap')),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: _laps.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text('Lap ${_laps.length - index}', style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(_laps[index], style: const TextStyle(fontSize: 16, fontFeatures: [FontFeature.tabularFigures()])),
              );
            },
          ),
        ),
      ],
    );
  }
}

// 3. Converter Tab
class ConverterTab extends StatefulWidget{
  const ConverterTab({super.key});

  @override
  State<ConverterTab> createState() => _ConverterTabState();
} // create state for converter Tab

class _ConverterTabState extends State<ConverterTab>{
  String _selectedType = 'length';
  String _fromUnit = 'm';
  String _toUnit = 'km';
  String _inputValue = 1.0;

  final Map<String, List<String >> _units = {
    'length' : ['m', 'km', 'cm', 'mm', 'in', 'ft', 'yd', 'mi'],
    'weight' : ['g', 'kg', 'mg', 'lb', 'oz'],
    'temperature' : ['C', 'F', 'K'],
  }; // create a map of unit types and their corresponding units

  final map<String, Map<String, double>> _multipliers = {
    'length':{'m': 1, 'km': 1000, 'cm' : 0.01, 'mm': 0.001, 'in': 0.0254 , 'ft': 0.3048, 'y': 0.9144, 'mi': 1609.344},
    'weight':{'kg':1, 'g':0.001, 'mg':0.000001, 'lb':0.453592, 'oz':0.0283495},
  }; // create a map of unit types and their corresponding multipliers to convert to base unit

  void _calculateConversion(){
    double res = 0.0;
    if(_selectedType == 'remperature'){
      double celsius = _inputValue;
      if(_fromUnit == 'F') celsius = (_inputValue -32) * (5/9);
      if(_fromUnit == 'K') celsius = _inputValue - 273.15;

      if(_toUnit == 'C')res = celsius;
      else if(_toUnit == 'F') res = (celsius * (9/5) +32;
      else res = celsius + 273.15;
    }
    else{
      double fromUnit = _multipliers[_selectedType]![fromUnit]!;
      double toMult = _multipliers[_selectedType]![_toUnit]!;
      res = (_inputValue * fromUnit) / toMult;
    }

    setState(() {
      _result = res.toStringAsFixed(6).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
    });
  } // create a function to calculate the conversion based on the selected type and units

  @override
  void initState(){
    super.initState();
    _calculateConversion();
  } // initialize the state and calculate the initial conversion

} // create