import 'package:flutter/material.dart';

circularProgress(){
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 12),
    child: const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.amber),
    ),
  );
}


linearProgress(){
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 12),
    child: const LinearProgressIndicator(
      color: Colors.cyan,
      valueColor: AlwaysStoppedAnimation(Colors.amber),
    ),
  );
}