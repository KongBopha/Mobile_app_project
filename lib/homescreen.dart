import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String _currentInput = "0"; //  display value
  String _previousInput = "0"; // second number
  String _operatorInput = "+";
  String _result = "0"; // result
  String _displayText = "0";

  static const List<String> buttonNum = [
    "7", "8", "9","+",
    "4", "5", "6", "-",
    "1", "2", "3","*",
    "C", "0", "=", "/",  
    ];
  static const List<String> numbers =[
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
  ];
  static const List<String> buttonOps = [
    "+", "-", "*", "/","=",
  ];
  bool foundMatch = false;

  void _onButtonPressed(String value) {
    setState(() {
      if(numbers.contains(value)){
        if(_currentInput == "0"){
          _currentInput = value;
          _displayText = _currentInput;
        }else{
          _currentInput += value;
          _displayText = _currentInput;
        }
      }else if(buttonOps.contains(value) && value != "="){
        _previousInput = _currentInput;
        _operatorInput = value;
         _currentInput = "0";
        _displayText = _operatorInput;
      }
      else if(value == "="){
      print("Previous Input: $_previousInput");
      print("Current Input: $_currentInput");
      print("Operation: $_operatorInput");
      
      int num1 = int.parse(_previousInput);
      int num2 = int.parse(_currentInput);

      switch(_operatorInput){
        case "+": 
        _result = (num1 + num2).toString();
        _displayText = _result;
        break;
        case "-":
        _result = (num1 - num2).toString();
        _displayText = _result;
        break;
        case "*":
        _result = (num1 * num2).toString();
        _displayText = _result;
        break;
        case "/":
        if(num2 != 0){
          _result = (num1 / num2).toString();
          _displayText = _result;
          }else{
            _displayText = "undefined";
          }
      }
      }
      else if(value == "C"){
        _currentInput = "0";
        _previousInput = "0";
        _operatorInput = "+";
        _result = "=";
        _displayText = "0";
      }
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.blue[100],
      ),
      body: Column(
        children: [
          // Display Screen
          Container(
            height: 120.0,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            alignment: Alignment.bottomRight,
            color: Colors.blue[100],
            child: Text(
              _displayText,
              style: const TextStyle(fontSize: 40, color: Colors.black),
            ),
          ),
          // Buttons Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),  
                itemCount: buttonNum.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, 
                  mainAxisSpacing: 8, 
                  crossAxisSpacing: 8, 
                  mainAxisExtent: 70, 
                ),
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () => _onButtonPressed(buttonNum[index]),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      buttonNum[index],
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
