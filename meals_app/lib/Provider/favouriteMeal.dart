import "package:meals_app/Data/Meal.dart";
import "package:riverpod/riverpod.dart";

//using this because if you want to edit or change the data then this is what you have to do
class favouriteNotifier extends StateNotifier<List<Meal>>{
  favouriteNotifier(): super([]);

  //now you cannot directly edit the parameters in this class, therefore it requires different methods

  bool addMeals(Meal meal){
    bool isMealThere = state.contains(meal);

    if (isMealThere){
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else{
      state = [...state, meal];
      return true;
    }
  }


}

final favouriteMealProivder = StateNotifierProvider<favouriteNotifier, List<Meal>>((ref) => 
    favouriteNotifier()
);