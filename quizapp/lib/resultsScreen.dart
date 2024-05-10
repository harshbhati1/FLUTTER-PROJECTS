import 'package:flutter/material.dart';
import 'package:quizapp/questions/data.dart';

class resultScreen extends StatelessWidget {
  final void Function() changeScreen;
  final List<String> answer;
  const resultScreen(this.changeScreen,{super.key, required this.answer});


  List<Map<String,Object>> getSummaryData(){
    List<Map<String,Object>> summary = [];
    for(int i = 0;i<answer.length;i++){
      summary.add({
        "Question-Index" : i,
        "Question" : questions[i].question,
        "Correct-answer": questions[i].answers[0],
        "User-answer":answer[i]

      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final totalQuestion = summaryData.length;
    final  correctAnswer = summaryData.where((element) {
      return element['User-answer'] == element['Correct-answer'];
  }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("You answered $correctAnswer out of $totalQuestion questions correctly"),
          const SizedBox(
            height: 30,
          ),
        const  Text("list of questions and answeres"),
          TextButton(onPressed: changeScreen, child:const Text("Restart"))
        ]),
      ),
    );
  }
}