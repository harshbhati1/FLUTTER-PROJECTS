import 'package:flutter/material.dart';
import 'package:quizapp/answerButton.dart';
import 'package:quizapp/questions/data.dart';
import 'package:google_fonts/google_fonts.dart';


class questionscreen extends StatefulWidget {
  const questionscreen(this.onSelected,{super.key});
  final void Function(String answer) onSelected;

  @override
  State<questionscreen> createState() => _questionscreenState();
}

class _questionscreenState extends State<questionscreen> {
  var answerIndex = 0;

  void nextQuestion(String answer){
    setState(() {
widget.onSelected(answer);
      answerIndex++;
    });
  }
  @override
  Widget build(BuildContext context) {
    var data1 = questions[answerIndex];
    return  Container(
      margin: const EdgeInsets.all(60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(data1.question, style: GoogleFonts.lato(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,), 
         const SizedBox( height: 40.0),
         ...data1.getShuffeledlist().map((answer) => answerBut(answer,(){
          nextQuestion(answer);
         }))
          
      ],
      ),
    );
  }
}