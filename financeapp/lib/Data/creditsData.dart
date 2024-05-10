import 'package:financeapp/Data/expensesData.dart';
import 'package:flutter/material.dart';


class Cred {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final CredCategories category;

  Cred({ required this.title, required this.amount, required this.date, required this.category}): id = uuid.v4();

  get formattedDate {
  return formatter.format(date);

}


}

enum CredCategories {work, gifts}

var credIcons = {
  CredCategories.work : Icons.work,
  CredCategories.gifts:Icons.redeem
};


class creditBucket{
   const creditBucket ( this.creditList, this.Category);
   creditBucket.forCategory(List<Cred> allCredit, this.Category): creditList = allCredit.where((credit) => credit.category == Category).toList();
   
  final CredCategories Category;
  final List<Cred> creditList;

 


  double get totalCredit{
    double sum = 0;

    for(final cred in creditList){
      sum+=cred.amount;
    }
    return sum;
  }
}

