import 'package:flutter/material.dart';

class mealIcon extends StatelessWidget {
  const mealIcon({required this.icon, required this.label, super.key});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Icon(icon, color: Colors.white, size: 17, ),
        const SizedBox( width: 6,),
        Text(label, style: const TextStyle(color: Colors.white),)
      ],
    );
  }
}