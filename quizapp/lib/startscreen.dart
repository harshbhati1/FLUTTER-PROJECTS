import 'package:flutter/material.dart';

class screen extends StatelessWidget {
  const screen({required this.change1,super.key});
  final void Function() change1;

  @override
  
  Widget build(BuildContext context) {
    return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/quiz-logo.png'), width: 300,color: Color.fromARGB(149, 255, 255, 255),),
                SizedBox(height: 40.0,),
                Text("Learn Flutter With Me!", style: TextStyle(color: Colors.white, fontSize: 20.0),),
                SizedBox(height: 30.0,),
                OutlinedButton.icon(onPressed: (){
                  change1();
                }, style: OutlinedButton.styleFrom(foregroundColor: Colors.white)
                ,icon: Icon(Icons.arrow_right_alt) ,label: Text("Start Quiz", style: TextStyle(color: Colors.white, fontSize: 15.0),))
          
              ],
            ),
          );
  }
}