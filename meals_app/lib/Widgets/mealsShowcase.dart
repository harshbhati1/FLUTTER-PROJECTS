import 'package:flutter/material.dart';
import 'package:meals_app/Data/Meal.dart';
import 'package:meals_app/Screen/eachMeal.dart';
import 'package:meals_app/Widgets/mealIcons.dart';
import 'package:transparent_image/transparent_image.dart';


class mealShowcase extends StatelessWidget {
  final Meal meal;
  const mealShowcase({required this.meal,super.key});
  

   void _displayMeal(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> eachMeal(meal: meal)));
}

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      child: InkWell(
        onTap: (){
          _displayMeal(context);
        },
        child: Stack(
          children: [
            Hero(tag: meal.id, child: FadeInImage(placeholder: MemoryImage(kTransparentImage), image: NetworkImage(meal.imageUrl),
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,)),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                children: [
                  Text(meal.title, maxLines: 2, overflow: TextOverflow.ellipsis, softWrap: true, 
                  style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, 
                    color: Colors.white
                  ),),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                mealIcon(icon: Icons.schedule, label: '${meal.duration} mins'),
                const SizedBox(width: 20,),
                mealIcon(icon: Icons.work, label: meal.complexity.name[0].toUpperCase()+ meal.complexity.name.substring(1)),
                 const SizedBox(width: 20,),
                mealIcon(icon: Icons.attach_money, label: meal.affordability.name[0].toUpperCase()+ meal.affordability.name.substring(1))

                    ],
                  )
                ],
                            ),
              ))
          ],
        ),
      ),
    );
  }
}