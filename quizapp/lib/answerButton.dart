import 'package:flutter/material.dart';

class answerBut extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const answerBut(this.text, this.onTap,{super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(onPressed: onTap, style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0))),child: Text(text, 
      textAlign: TextAlign.center,)),
    );
  }
}