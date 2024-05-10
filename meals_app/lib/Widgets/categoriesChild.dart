import 'package:flutter/material.dart';
import 'package:meals_app/Data/categories.dart';

class categoriesChild extends StatelessWidget {
  const categoriesChild({required this.selectCategory,required this.category,super.key});
  final void Function() selectCategory;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell( // can also use gesturedetector but there will be no effect 
    onTap: selectCategory,
    splashColor: Theme.of(context).primaryColor,
    borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: [
           category.color.withOpacity(0.55),
           category.color.withOpacity(0.9)
          ]
          )
        ),
        child: Text(category.title, style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground
        ),),
      ),
    );
  }
}