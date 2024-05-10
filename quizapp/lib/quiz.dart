import 'package:flutter/material.dart';
import 'package:quizapp/questions/data.dart';
import 'package:quizapp/questionscreen.dart';
import 'package:quizapp/resultsScreen.dart';
import 'package:quizapp/startscreen.dart';

class quiz extends StatefulWidget {
  const quiz({super.key});

  @override
  State<quiz> createState() => _quizState();
}

class _quizState extends State<quiz> {
  var currentScreen = 'Start-screen';
  List <String> Selectedanswers = [];

  void storingAnswer(String answer){

    Selectedanswers.add(answer);
    if(Selectedanswers.length==questions.length){
     setState(() {
        Selectedanswers = [];
      currentScreen = 'Result-screen';
      
     });
    }


  }
  void Switchscreen2(){
    setState(() {
      currentScreen = 'Start-screen';
    });
  }

  void Switchscreen(){
    setState(() {
      currentScreen = 'Question-screen';
    });
    
  }
  @override
  Widget build(BuildContext context) {
    Widget screenWidget = screen(change1: Switchscreen);
    if (currentScreen=='Question-screen'){
      screenWidget = questionscreen(storingAnswer);
    }
    else if(currentScreen=='Result-screen'){
      screenWidget = resultScreen(Switchscreen2, answer: Selectedanswers);
    }else{
      screenWidget = screen(change1: Switchscreen);
    }
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue, const Color.fromARGB(255, 3, 101, 181)])
          ),
          child: Center(child: screenWidget))
        ),
      );
    
  }
}