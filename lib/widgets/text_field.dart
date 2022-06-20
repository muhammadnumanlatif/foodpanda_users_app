import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  MyTextField({Key? key, this.hint, this.controller}) : super(key: key);

  final String? hint;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
    child: TextFormField(

        controller: controller,
      decoration: InputDecoration.collapsed(
        hintText: hint
      ),

      validator: (value)=>value!.isEmpty?"Field cannot be empty":null,
    ),
    );
  }
}
