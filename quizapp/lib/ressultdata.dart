import 'package:flutter/material.dart';

class resultData extends StatelessWidget {
  final List<Map<String,Object>> resultdataval;
  const resultData({ required this.resultdataval,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: resultdataval.map((answer){
        return Row()
      }
      )
    );
  }
}