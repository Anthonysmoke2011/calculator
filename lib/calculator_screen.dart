import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});
  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _input = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operator = "";

  void _handleButtonClick(String value) {
    setState(() {
      if (value == "C") {
        _clear();
      } else if (value == "=") {
        _calculate();
      } else if (value == "+" || value == "-" || value == "x" || value == "/") {
        _setOperator(value);
      } else {
        _appendDigit(value);
      }
    });
  }

  void _clear() {
    _output = "0";
    _input = "";
    _num1 = 0;
    _num2 = 0;
    _operator = "";
  }

  void _calculate() {
    if (_num1 != 0 && _operator.isNotEmpty && _input.isNotEmpty) {
      _num2 = double.parse(_input);
      switch (_operator) {
        case "+":
          _output = (_num1 + _num2).toString();
          break;
        case "-":
          _output = (_num1 - _num2).toString();
          break;
        case "x":
          _output = (_num1 * _num2).toString();
          break;
        case "/":
          _output = (_num1 / _num2).toString();
          break;
      }
      _input = "";
      _num1 = double.parse(_output);
      _operator = "";
    }
  }

  void _setOperator(String operator) {
    if (_num1 == 0 && _input.isNotEmpty) {
      _num1 = double.parse(_input);
      _operator = operator;
      _input = "";
    } else if (_num1 != 0 && _input.isNotEmpty && _operator.isNotEmpty) {
      _calculate();
      _operator = operator;
    }
  }

  void _appendDigit(String digit) {
    if (_input == "0" && digit == "0") {
      return; // Prevent leading zeros
    }

    _input += digit;
    _output = _input;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding:const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: const TextStyle(fontSize: 48.0),
              ),
            ),
          ),
          const Divider(),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (context, index) {
              final buttonText = _buttonLabels[index];
              return TextButton(
                onPressed: () => _handleButtonClick(buttonText),
                child: Text(
                  buttonText,
                  style:const TextStyle(fontSize: 24.0),
                ),
              );
            },
            itemCount: _buttonLabels.length,
          ),
        ],
      ),
    );
  }

  final List<String> _buttonLabels = [
    '7', '8', '9', '/',
    '4', '5', '6', 'x',
    '1', '2', '3', '-',
    '0', 'C', '=', '+',
  ];
}