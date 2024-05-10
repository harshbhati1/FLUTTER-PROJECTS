import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Data/Meal.dart';
import 'package:meals_app/Provider/favouriteMeal.dart';
import 'package:meals_app/Provider/mealsProvider.dart';

class eachMeal extends ConsumerWidget {
  final Meal meal;
  
   eachMeal({ required this.meal,super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeal = ref.watch(favouriteMealProivder);
    final isFavourite = favouriteMeal.contains(meal);
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [IconButton(onPressed:(){
        bool isTitle =  ref.read(favouriteMealProivder.notifier).addMeals(meal);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isTitle?"Meal is added":"Meal is removed")));
        }, icon:  AnimatedSwitcher(duration:const Duration(milliseconds: 300) , child: Icon(isFavourite?Icons.star: Icons.star_border, key: ValueKey(isFavourite),),
        transitionBuilder: (child, animation) => RotationTransition(turns: Tween(begin: 0.9, end: 1.0 ).animate(animation), child: child,),
        )), 
        const SizedBox(width: 10,)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(tag: meal.id, child: Image.network(meal.imageUrl, width: double.infinity, height: 300, fit: BoxFit.cover,),),
            const SizedBox(height: 10,),
            Text("Ingridients", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary, fontSize: 30
            ),),
             const SizedBox(height: 10,),
             for (final ingrid in meal.ingredients)
             Text(ingrid,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground, fontSize: 20
            ), ),
            const SizedBox(height: 10,),
             Text("Steps", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary, fontSize: 30
            ),),
            const SizedBox(height: 10,),
             for (final step in meal.steps)
             Padding(padding:const EdgeInsets.symmetric( horizontal: 12, vertical: 6),
             child:Text(step,textAlign: TextAlign.center ,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground, fontSize: 20
            ), ),)

          ],
        ),
      )
    );
  }
}