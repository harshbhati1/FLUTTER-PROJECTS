import 'package:meals_app/Data/categoriesData.dart';
import 'package:riverpod/riverpod.dart';

var mealsProvider = Provider((ref) {
  return dummyMeals;
});