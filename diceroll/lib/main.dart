import 'package:flutter/material.dart';
import 'dart:math';

void main(){
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Gradientcolor(values: [Colors.black, Colors.white])
      ),
    );
  }
}



class Gradientcolor extends StatelessWidget{
  List<Color> values;

  Gradientcolor({required this.values, super.key});
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: this.values),
      ),
      child: Center(
        child: roller(),
      ) ,
    );
    

  }
}


class roller extends StatefulWidget {
  
  const roller({super.key});

  @override
  State<roller> createState() => _rollerState();
}

class _rollerState extends State<roller> {
  @override
  Random a = Random();
  var b = 1;
  void changer(){
   setState(() {
      b = a.nextInt(6)+1;
   });
  }
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("dic$b.png", width: 200,),
       const SizedBox( 
          height: 30.0,
        ),
        TextButton(onPressed: changer, style:TextButton.styleFrom(foregroundColor: Colors.white),child: const Text("Roll", style: TextStyle(fontSize: 20.0),))

      ],
    );
  }
}