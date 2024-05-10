import 'package:financeapp/Data/expensesData.dart';
import 'package:financeapp/Widgets/expenseScreenCard.dart';
import 'package:flutter/material.dart';

class expenseCardhelper extends StatelessWidget {
  final List<Exp> expenseData;
  final void Function(Exp expense) deleteExpense;
  const expenseCardhelper({ required this.deleteExpense,required this.expenseData,super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: expenseData.length,
    itemBuilder: (context, index) => Dismissible(key: ValueKey( expenseCard(expense: expenseData[index])) ,onDismissed: (direction) => deleteExpense(expenseData[index]), background: Container(
      color: const Color.fromARGB(255, 196, 192, 192),  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    ),child: expenseCard(expense: expenseData[index])));
  }
}