import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final String prefix;
  final String label;
  final TextEditingController c;
  final Function f;

  const BuildTextField({Key? key, required this.label,
    required this.prefix, required this.c,
    required this.f}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.amber,
        ),
        border: const OutlineInputBorder(),
        prefixText: prefix,
        prefixStyle: TextStyle(
          color: Colors.amber,
        fontSize: 25,
        )
      ),
      style: const TextStyle(
        color: Colors.amber,
        fontSize: 25,
      ),
      onChanged: f as void Function(String),
      keyboardType: TextInputType.number,
      );
  }
}
