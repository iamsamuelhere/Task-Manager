import 'package:flutter/material.dart';

class Textinput extends StatelessWidget {
  const Textinput({ @required this.taskname,
  this.hint,this.label,this.icon});

  final TextEditingController taskname;
  final String hint;
  final String label;
  final IconData icon;
  

  @override
  Widget build(BuildContext context) {
    return TextFormField(
 
      controller: taskname,
      decoration: InputDecoration(
          
          hintText: hint,
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0))),
    );
  }
}