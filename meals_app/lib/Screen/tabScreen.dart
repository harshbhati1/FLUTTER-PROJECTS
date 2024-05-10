import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Data/Meal.dart';
import 'package:meals_app/Data/categoriesData.dart';
import 'package:meals_app/Provider/favouriteMeal.dart';
import 'package:meals_app/Screen/categoriesScreen.dart';
import 'package:meals_app/Screen/filter.dart';
import 'package:meals_app/Screen/mealScreen.dart';
import 'package:riverpod/riverpod.dart';
import 'package:meals_app/Provider/mealsProvider.dart';
import 'package:meals_app/Provider/filtersProvider.dart';

const kInitialVariable = {
    Filter.glutenFree :false,
    Filter.lactoseFree :false,
    Filter.vegetarian: false,
    Filter.vegan: false
  };

class tabScreen extends ConsumerStatefulWidget {
  const tabScreen({super.key});
 
  @override
  ConsumerState<tabScreen> createState() => _tabScreenState();
}

class _tabScreenState extends ConsumerState<tabScreen> {
  int index = 0;
  void _changeIndex(int index){
setState(() {
  this.index = index;
});
  }


  // favourite meal things 

  
    

  void _snackMessanger(String answer){ // for shwoing whether the meal is added or not 
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(answer)));

  }
  void _screenIdentifier (String value) async{
    Navigator.of(context).pop();
    if(value=='filter') {
     await Navigator.of(context).push<Map<Filter,bool>>(MaterialPageRoute(builder: (ctx)=>  const Filters()));
     
    }
    
  }
 
  @override
  Widget build(BuildContext context) {
  
     var availableMeal = ref.read(filterMealProvider);
     Widget mainScreen = categoriesScreen(availableMeal: availableMeal,screenIdentifier: _screenIdentifier,);
   var appTitle = "Categories";
    if (index==1){
      final favouriteMeal = ref.watch(favouriteMealProivder); 
      mainScreen = mealScreen(title: "Favourites", meal: favouriteMeal);
      appTitle = "Favourites";
    } else if (index ==0){
      mainScreen = categoriesScreen(availableMeal: availableMeal,screenIdentifier: _screenIdentifier,);
      appTitle = "Categories";
    }

   
    return Scaffold(
      
      body: mainScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          _changeIndex(index);
        },
        currentIndex: index ,
        items: const [BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories'), 
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourite')],
      ),
    );
  }
}