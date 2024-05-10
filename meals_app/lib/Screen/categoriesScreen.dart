import 'package:flutter/material.dart';
import 'package:meals_app/Data/Meal.dart';
import 'package:meals_app/Data/categories.dart';
import 'package:meals_app/Data/categoriesData.dart';
import 'package:meals_app/Screen/drawer.dart';
import 'package:meals_app/Screen/mealScreen.dart';
import 'package:meals_app/Widgets/categoriesChild.dart';

class categoriesScreen extends StatefulWidget {
  @override
  final List<Meal> availableMeal;
  final void Function(String value) screenIdentifier;
  const categoriesScreen({required this.availableMeal,required this.screenIdentifier,super.key});

  @override
  State<categoriesScreen> createState() => _categoriesScreenState();
}

class _categoriesScreenState extends State<categoriesScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
   
    super.initState();
    _animationController = AnimationController(vsync: this,
    duration: const Duration(milliseconds: 300),
    lowerBound: 0,
    upperBound: 1
    );
     _animationController.forward();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }
  void _selectCategory(BuildContext context, Category category){
    final filteredMeals = widget.availableMeal.where((meal) => meal.categories.contains(category.id)).toList(); 

    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> 
    mealScreen(title: category.title, meal: filteredMeals)));
  }

  @override
  Widget build(BuildContext context) {
   
    return AnimatedBuilder(animation: _animationController, builder:  ((context, child) => SlideTransition(
      position: 
        Tween(
          begin: const Offset(0, 1),
          end : const Offset(0,0)
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Main Screen"),
          centerTitle: true,
        ),
        drawer: helperDrawer(screenIdentifier: widget.screenIdentifier,),
        body: GridView(
         padding:const EdgeInsets.all(24.0) 
        ,gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
        mainAxisSpacing: 20,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20), 
        children:  [
       for(final category in availableCategories )
        categoriesChild(selectCategory:() => _selectCategory(context, category) ,category: category)
      
        ],),
      ),
    )));
  }
}