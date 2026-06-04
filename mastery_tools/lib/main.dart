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
      
      // Use ShuntingYardParser instead of deprecated Parser
      final p = ShuntingYardParser();
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
class StopwatchTab extends StatefulWidget {
  const StopwatchTab({super.key});

  @override
  State<StopwatchTab> createState() => _StopwatchTabState();
}

class _StopwatchTabState extends State<StopwatchTab> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  final List<String> _laps = [];

  void _startTimer() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
        setState(() {});
      });
    }
  }

  void _pauseTimer() {
    _stopwatch.stop();
    _timer?.cancel();
    setState(() {});
  }

  void _resetTimer() {
    _stopwatch.reset();
    _stopwatch.stop();
    _timer?.cancel();
    setState(() {
      _laps.clear();
    });
  }

  void _recordLap() {
    if (_stopwatch.isRunning) {
      setState(() {
        _laps.insert(0, _formattedTime());
      });
    }
  }

  String _formattedTime() {
    final int milli = _stopwatch.elapsedMilliseconds;
    final int centi = (milli % 1000) ~/ 10;
    final int sec = (milli ~/ 1000) % 60;
    final int min = (milli ~/ 60000) % 60;
    final int hr = milli ~/ 3600000;
    return '${hr.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}.${centi.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
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
class ConverterTab extends StatefulWidget {
  const ConverterTab({super.key});

  @override
  State<ConverterTab> createState() => _ConverterTabState();
}

class _ConverterTabState extends State<ConverterTab> {
  String _selectedType = 'length';
  String _fromUnit = 'm';
  String _toUnit = 'km';
  double _inputValue = 1.0;
  String _result = '';

  final Map<String, List<String>> _units = {
    'length': ['m', 'km', 'cm', 'mm', 'in', 'ft', 'yd', 'mi'],
    'weight': ['kg', 'g', 'mg', 'lb', 'oz'],
    'temperature': ['C', 'F', 'K'],
  };

  final Map<String, Map<String, double>> _multipliers = {
    'length': {'m': 1, 'km': 1000, 'cm': 0.01, 'mm': 0.001, 'in': 0.0254, 'ft': 0.3048, 'yd': 0.9144, 'mi': 1609.344},
    'weight': {'kg': 1, 'g': 0.001, 'mg': 0.000001, 'lb': 0.453592, 'oz': 0.0283495},
  };

  void _calculateConversion() {
    double res = 0.0;
    if (_selectedType == 'temperature') {
      double celsius = _inputValue;
      if (_fromUnit == 'F') celsius = (_inputValue - 32) * (5 / 9);
      if (_fromUnit == 'K') celsius = _inputValue - 273.15;

      // ignore: curly_braces_in_flow_control_structures
      if (_toUnit == 'C') res = celsius;
      // ignore: curly_braces_in_flow_control_structures
      else if (_toUnit == 'F') res = celsius * (9 / 5) + 32;
      // ignore: curly_braces_in_flow_control_structures
      else res = celsius + 273.15;
    } else {
      double fromMult = _multipliers[_selectedType]![_fromUnit]!;
      double toMult = _multipliers[_selectedType]![_toUnit]!;
      res = (_inputValue * fromMult) / toMult;
    }

    setState(() {
      _result = res.toStringAsFixed(6).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
    });
  }

  @override
  void initState() {
    super.initState();
    _calculateConversion();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildDropdownRow('Type', _units.keys.toList(), _selectedType, (val) {
            setState(() {
              _selectedType = val!;
              _fromUnit = _units[_selectedType]![0];
              _toUnit = _units[_selectedType]![1 % _units[_selectedType]!.length];
              _calculateConversion();
            });
          }),
          const SizedBox(height: 15),
          _buildDropdownRow('From', _units[_selectedType]!, _fromUnit, (val) {
            setState(() { _fromUnit = val!; _calculateConversion(); });
          }),
          const SizedBox(height: 15),
          _buildDropdownRow('To', _units[_selectedType]!, _toUnit, (val) {
            setState(() { _toUnit = val!; _calculateConversion(); });
          }),
          const SizedBox(height: 15),
          Row(
            children: [
              const SizedBox(width: 80, child: Text('Value:', style: TextStyle(color: Colors.grey))),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                  onChanged: (val) {
                    setState(() {
                      _inputValue = double.tryParse(val) ?? 0.0;
                      _calculateConversion();
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Text(
              'Result: $_result',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDropdownRow(String label, List<String> items, String currentValue, ValueChanged<String?> onChanged) {
    return Row(
      children: [
        SizedBox(width: 80, child: Text(label, style: const TextStyle(color: Colors.grey))),
        Expanded(
          child: DropdownButtonFormField<String>(
            // ignore: deprecated_member_use
            value: currentValue,
            decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 10)),
            items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

//  GPA Calculator Tab (With Local Storage)
class GPACalculatorPage extends StatefulWidget{
  const GPACalculatorPage({super.key});

  @override
  State<GPACalculatorPage> createState() => _GPACalculatorPage();
}  // create a GPA Calculator page with the ability to add courses, calculate GPA, and save/load data using SharedPreferences.

class _GPACalculatorPageState extends State<GPACalculatorPage>{
  List<Map<String, dynamic>> _courses = [] ;

  final Map<String, double> _gradeScale = {
    'A (4.0)': 4.0, 'A- (3.7)': 3.7, 'B+ (3.3)': 3.3,
    'B (3.0)': 3.0, 'B- (2.7)': 2.7, 'C+ (2.3)': 2.3,
    'C (2.0)': 2.0, 'D (1.0)': 1.0, 'F (0.0)': 0.0,
  };

  @override
  void initState(){
    super.initState();
    _loadSaveData(); // Load data when the page opens
  } //  create a function to load saved data from SharedPreferences when the page initializes.

  // Storage Logic
  Future<void> _loadSavedData() async{
    final prefs = await SharedPreferences.getInstance();
    final String? coursesJson = prefs.getString('saved_gpa_courses');

    if(coursesJson != null){
      final List<dynamic> decoded = jsonDecode(coursesJson);
      setState(() {
        _courses = decoded.map((e) => Map<String, dynamic>.from(e)).toList(); 
      }); // This will convert the JSON string back into a List of Maps and update the state to reflect the loaded courses.
    } // If there is saved data, it decodes the JSON string and updates the _courses list with the loaded courses.
    else{
      // Default empty state if nothing is saved 
      setState(() {
        _courses = [{'name': '', 'grade' : 4.0, 'credits':3}];  _
      });
    }
  } // create a function to save the current courses data to SharedPreferences whenever changes are made, such as adding a course or updating grades/credits.

  Future<void> _saveData() async{
    final prefs = await SharePreferences.getInstance();
    final String encoded = jsonEncode(_courses);
    await prefs.setString('saved_gpa_courses', encoded);
  }// This function encodes the current _courses list into a JSON string and saves it to SharedPreferences under the key 'saved_gpa_courses'. It should be called whenever there are changes to the courses data to ensure that the latest information is saved.


  void _addCourse() {
    setState(() {
      _courses.add({'name': '', 'grade': 4.0, 'credits': 3});
    });
    _saveData();
  } // This function adds a new course with default values to the _courses list and then calls _saveData() to save the updated list to SharedPreferences.

  String _calculateGPA() {
    double totalPoints = 0;
    int totalCredits = 0;
    for (var course in _courses) {
      totalPoints += (course['grade'] * course['credits']);
      totalCredits += (course['credits'] as int);
    } // This loop iterates through each course in the _courses list, multiplying the grade by the credits to calculate the total points and summing up the total credits.
    if (totalCredits == 0) return '0.00';
    return (totalPoints / totalCredits).toStringAsFixed(2);
  } // This function calculates the GPA by iterating through the _courses list, multiplying each course's grade by its credits to get total points, and summing up the total credits. It then divides total points by total credits to get the GPA and formats it to two decimal places.

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPA Calculator'),
        backgroundColor: const Color(0xFF0ea5e9),
        foregroundColor: Colors.white,
      ), // The AppBar is set with a title "GPA Calculator" and styled with a specific background color and white text.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _courses.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          // Course Name Field
                          TextField(
                            decoration: const InputDecoration(
                              labelText: 'Course Name (e.g., Math 101)',
                              border: UnderlineInputBorder(),
                            ), // This TextField allows the user to input the course name. It uses a TextEditingController initialized with the current course name and updates the _courses list and saves data whenever the text changes.
                            controller: TextEditingController(text: _courses[index]['name'])
                              ..selection = TextSelection.collapsed(offset: _courses[index]['name'].length),
                            onChanged: (val) {
                              _courses[index]['name'] = val;
                              _saveData();
                            },
                          ), // This TextField allows the user to input the course name. It uses a TextEditingController initialized with the current course name and updates the _courses list and saves data whenever the text changes.
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              // Grade Dropdown
                              Expanded(
                                flex: 2,
                                child: DropdownButton<double>(
                                  value: _courses[index]['grade'],
                                  isExpanded: true,
                                  items: _gradeScale.entries.map((e) {
                                    return DropdownMenuItem(value: e.value, child: Text(e.key));
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() => _courses[index]['grade'] = val);
                                    _saveData();
                                  },
                                ), // This DropdownButton allows the user to select a grade for the course. It is populated with the entries from the _gradeScale map, and when a grade is selected, it updates the _courses list and saves the data.
                              ), // This DropdownButton allows the user to select a grade for the course. It is populated with the entries from the _gradeScale map, and when a grade is selected, it updates the _courses list and saves the data.
                              const SizedBox(width: 10),
                              // Credits Field
                              Expanded(
                                child: TextField(
                                  decoration: const InputDecoration(labelText: 'Credits'),
                                  keyboardType: TextInputType.number,
                                  controller: TextEditingController(text: _courses[index]['credits'].toString())
                                    ..selection = TextSelection.collapsed(offset: _courses[index]['credits'].toString().length),
                                  onChanged: (val) {
                                    setState(() {
                                      _courses[index]['credits'] = int.tryParse(val) ?? 0;
                                    });
                                    _saveData();
                                  },
                                ), // This TextField allows the user to input the number of credits for the course. It is initialized with the current credits value and updates the _courses list and saves data whenever the text changes.
                              ),
                              // Delete Button
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() => _courses.removeAt(index));
                                  _saveData();
                                },
                              ) // create an IconButton with a delete icon that allows the user to remove a course from the list. When pressed, it removes the course at the specified index from the _courses list and saves the updated data to SharedPreferences.
                            ], // This Row contains the grade dropdown, credits field, and delete button for each course entry, allowing the user to manage their courses effectively.
                          ), // This Row contains the grade dropdown, credits field, and delete button for each course entry, allowing the user to manage their courses effectively.
                        ], // The Column contains the course name TextField and a Row with the grade dropdown, credits field, and delete button for each course entry.
                      ),
                    ),
                  );
                },
              ), // The ListView.builder creates a scrollable list of course entries based on the _courses list. Each entry is displayed as a Card containing the course name, grade selection, credits input, and a delete button.
            ),
            // Bottom Results Panel
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50, 
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blue.shade200)
              ), // This Container serves as a bottom panel to display the calculated GPA and an option to add more courses. It is styled with a light blue background, rounded corners, and a border.
              child: Column(
                children: [
                  Text('Cumulative GPA: ${_calculateGPA()}', 
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1f2937))
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _addCourse,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Another Course'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0ea5e9),
                      foregroundColor: Colors.white,
                    ),
                  ), // This ElevatedButton allows the user to add a new course entry to the list. When pressed, it calls the _addCourse function, which adds a new course with default values to the _courses list and saves the updated data to SharedPreferences.
                ], // The Column contains a Text widget that displays the calculated GPA and an ElevatedButton that allows the user to add another course to the list.
              ), // This Container serves as a bottom panel to display the calculated GPA and an option to add more courses. It is styled with a light blue background, rounded corners, and a border.
            ),
          ], // The main Column of the page contains the ListView of courses and a bottom Container that displays the GPA and an option to add more courses.
        ),
      ),
    ); // create a Scaffold with an AppBar titled "GPA Calculator" and a body that contains a ListView of course entries and a bottom panel to display the calculated GPA and an option to add more courses.
  } // The build method constructs the UI of the GPA Calculator page, including the AppBar, a ListView for managing courses, and a bottom panel for displaying the GPA and adding new courses.
 // This class defines the state and UI for the GPA Calculator page, allowing users to add courses, input grades and credits, calculate their GPA, and save/load their data using SharedPreferences.
