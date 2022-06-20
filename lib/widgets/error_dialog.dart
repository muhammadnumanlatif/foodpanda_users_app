import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key, this.message}) : super(key: key);
final String? message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key:key,
      content: Text(message!),
      actions: [
        ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child:  Center(child: Text("OK"),),
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
        ),
        )
      ],
    );
  }
}
