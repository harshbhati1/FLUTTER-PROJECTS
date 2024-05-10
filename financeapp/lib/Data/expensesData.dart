
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';


// extra packages
const uuid = Uuid();
final formatter = DateFormat.yMd();


class Exp {
  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Categories category;
  
  Exp({required this.title, required this.amount, required this.date, required this.category}): id = uuid.v4();

  get formattedDate {
  return formatter.format(date);

}





}

enum Categories {work, food, leisure, travel}

// categorising icons 

var categoriesIcon = {
  Categories.food: Icons.lunch_dining,
  Categories.work: Icons.work,
  Categories.leisure : Icons.movie,
  Categories.travel: Icons.flight_takeoff
};


class ExpenseBucket{
   const ExpenseBucket ( this.expenseList, this.Category);
   ExpenseBucket.forCategory(List<Exp> allExpenses, this.Category): expenseList = allExpenses.where((expense) => expense.category== Category).toList();
   
  final Categories Category;
  final List<Exp> expenseList;

 


  double get totalExpenses{
    double sum = 0;

    for(final exp in expenseList){
      sum+=exp.amount;
    }
    return sum;
  }
}

