import 'package:flutter/material.dart';
import 'package:meals_app/Data/Meal.dart';
import 'package:meals_app/Widgets/mealsShowcase.dart';

class mealScreen extends StatelessWidget {
 
  const mealScreen({required this.title,required this.meal,super.key});
   final List<Meal> meal;
  final String title;

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Uhh no dishes found!!!!!", style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),),
         const SizedBox( height: 20.0,),
         Text("Try something different......", style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.onBackground
         ),)
      
        ],
      ),
    );
    if(meal.isNotEmpty){
      content = ListView.builder(itemCount: meal.length,itemBuilder: (context, index)=>
       mealShowcase( meal:meal[index])
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ) ,
      body:content ,
    );
  }
}