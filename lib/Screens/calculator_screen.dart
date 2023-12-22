import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  int _userInput1 = 0;
  int _userInput2 = 0;
  String calculationHistory = '';
  String _operand = '';
  String _output = '';
  String result = '';

  void _buttonPressed(String buttonText) {
    setState(() {
      switch (buttonText) {
        case 'C':
          _output = '';
          _userInput1 = 0;
          _userInput2 = 0;
          _operand = '';
          result = '';
          calculationHistory = '';
          break;
        case '+':
        case '-':
        case '*':
        case '/':
          _userInput1 = int.parse(_output);
          _operand = buttonText;
          result = '';
          break;
        case '=':
          _userInput2 = int.parse(_output);
          if (_operand == '+') {
            result = (_userInput1 + _userInput2).toString();
            calculationHistory = _userInput1.toString() +
                _operand.toString() +
                _userInput2.toString();
          }
          if (_operand == '-') {
            result = (_userInput1 - _userInput2).toString();
            calculationHistory = _userInput1.toString() +
                _operand.toString() +
                _userInput2.toString();
          }
          if (_operand == '*') {
            result = (_userInput1 * _userInput2).toString();
            calculationHistory = _userInput1.toString() +
                _operand.toString() +
                _userInput2.toString();
          }
          if (_operand == '/') {
            result = (_userInput1 / _userInput2).toString();
            calculationHistory = _userInput1.toString() +
                _operand.toString() +
                _userInput2.toString();
          }
          _userInput1 = 0;
          _userInput2 = 0;
          _operand = '';
          break;
        default:
          result = (_output + buttonText).toString();
      }

      setState(() {
        _output = result;
      });
    });
  }

  Widget _buildButton(
    String buttonText,
    Color buttonColor,
    Color textColor,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            foregroundColor: textColor,
            backgroundColor: buttonColor,
            padding: const EdgeInsets.all(20.0),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      children: buttons
          .map(
            (button) => _buildButton(
              button,
              button == 'C' ? Colors.grey[700]! : Colors.grey[900]!,
              button == '=' ||
                      button == '/' ||
                      button == '*' ||
                      button == '-' ||
                      button == '+'
                  ? Colors.white
                  : Colors.amber,
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          Text(
            calculationHistory,
            style: const TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _output,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(height: 0.0),
          Column(
            children: [
              // Rows of buttons
              _buildButtonRow(['7', '8', '9', '/']),
              _buildButtonRow(['4', '5', '6', '*']),
              _buildButtonRow(['1', '2', '3', '-']),
              _buildButtonRow(['C', '0', '=', '+']),
            ],
          ),
        ],
      ),
    );
  }
}
