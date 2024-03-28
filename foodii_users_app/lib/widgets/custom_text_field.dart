import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  late final TextEditingController? controller;
  late final IconData? data;
  late final String? hintText;
  bool? isObsecre = true;
  bool? enabled = true;

  CustomTextField({
    this.controller,
    this.data,
    this.hintText,
    this.isObsecre,
     this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: isObsecre!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(data, color: Colors.cyan,),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText
        ),
      ),
     
    );
  }
}