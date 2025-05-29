import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      home: CalculatorHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _expression = '';
  String _result = '';

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
      } else if (value == '=') {
        try {
          _result = _calculate(_expression);
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += value;
      }
    });
  }

  String _calculate(String expr) {
    try {
      final exp = expr.replaceAll('×', '*').replaceAll('÷', '/');
      final result = _evaluate(exp);
      return result.toString();
    } catch (e) {
      return 'Error';
    }
  }

  double _evaluate(String expr) {
    // Basic arithmetic expression evaluator
    final tokens = expr.split(RegExp(r'([\+\-\*/])')).map((e) => e.trim()).toList();
    double total = double.parse(tokens[0]);

    for (int i = 1; i < tokens.length; i += 2) {
      String op = tokens[i];
      double num = double.parse(tokens[i + 1]);

      if (op == '+') total += num;
      if (op == '-') total -= num;
      if (op == '*') total *= num;
      if (op == '/') total /= num;
    }
    return total;
  }

  Widget _buildButton(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _onPressed(label),
          child: Text(label, style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_expression, style: TextStyle(fontSize: 32)),
                  SizedBox(height: 10),
                  Text(_result, style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(children: [_buildButton('7'), _buildButton('8'), _buildButton('9'), _buildButton('÷')]),
              Row(children: [_buildButton('4'), _buildButton('5'), _buildButton('6'), _buildButton('×')]),
              Row(children: [_buildButton('1'), _buildButton('2'), _buildButton('3'), _buildButton('-')]),
              Row(children: [_buildButton('0'), _buildButton('C'), _buildButton('='), _buildButton('+')]),
            ],
          )
        ],
      ),
    );
  }
}
