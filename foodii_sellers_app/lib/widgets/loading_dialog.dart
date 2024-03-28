import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {

  final String? message;
   LoadingDialog({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        const  CircularProgressIndicator(),
        const SizedBox(height: 10,),
          Text("${message!}, Please wait..."),
        ],
      ),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const  Center(
          child: Text("OK"),
        ))
      ],
    );
  }
}