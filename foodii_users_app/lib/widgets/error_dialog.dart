import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {

  final String? message;
   ErrorDialog({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message!),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child:  Center(
          child: Text("OK"),
        ), style: ElevatedButton.styleFrom(backgroundColor: Colors.red))
      ],
    );
  }
}