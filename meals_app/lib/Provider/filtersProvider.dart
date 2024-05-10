import 'package:meals_app/Provider/mealsProvider.dart';
import 'package:riverpod/riverpod.dart';


enum Filter{
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan
}

class filterClassNotifier extends StateNotifier<Map<Filter,bool>>{
  filterClassNotifier (): super({
    Filter.glutenFree: false,
    Filter.lactoseFree :false,
    Filter.vegetarian : false,
    Filter.vegan : false
  });

  void updateFilter(Filter filter, bool boolean){
    state = {...state, 
    filter:boolean};
  }

  void filtersUpdate(Map<Filter, bool> chosenFilter){
    state = chosenFilter;
  }

}

final filterProvider = StateNotifierProvider<filterClassNotifier, Map<Filter,bool>>((ref) => filterClassNotifier());

final filterMealProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilter = ref.watch(filterProvider);

    return meals.where((meal){
    if(activeFilter[Filter.glutenFree]! && !meal.isGlutenFree){
      return false;
    }if(activeFilter[Filter.lactoseFree]! && !meal.isLactoseFree){
      return false;
    }if(activeFilter[Filter.vegan]! && !meal.isVegan){
      return false;
    }if(activeFilter[Filter.vegetarian]! && !meal.isVegetarian){
      return false;
    }
    else{
      return true;
    }
  }).toList();
});