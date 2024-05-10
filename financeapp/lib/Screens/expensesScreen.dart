

import 'package:financeapp/Data/expensesData.dart';
import 'package:financeapp/Layovers/expensesLayover.dart';
import 'package:financeapp/Widgets/expenseChart.dart';
import 'package:financeapp/Widgets/expenseScreenCardhelper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class expensesScreen extends StatefulWidget {
  final void Function(Exp expense) addExpense;
  final void Function (Exp expense) delteExpense;
  final void Function(int index, Exp expense) insetExpense;
  final List<Exp> expenseData;
  const expensesScreen({required this.expenseData, required this.addExpense,required this.insetExpense,required this.delteExpense,super.key});

  @override
  State<expensesScreen> createState() => _expensesScreenState();
}

class _expensesScreenState extends State<expensesScreen> {

  void addingExpense(Exp expense){
    setState(() {
      widget.addExpense(expense);
    });
  }

  void deleteExpense(Exp expense){
    int index = widget.expenseData.indexOf(expense);
    setState(() {
      widget.delteExpense(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Expense Deleted", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),
     duration: const Duration(seconds: 3),
    
     backgroundColor: const Color(0xFFF19E8E),
     action: SnackBarAction(label: "Undo", textColor: Colors.white,onPressed: (){
      setState(() {
        widget.insetExpense(index,expense);
      });
     }),));
  }
 
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget mainExpenseScreen = Container(margin:const EdgeInsets.all(30),child: Center(child: Text("Seems like you don't have any expense right now!", style:GoogleFonts.comfortaa(fontSize: 20.0, color:Colors.white ),)));
    if(widget.expenseData.isNotEmpty){
      mainExpenseScreen =  width<600 ?Column(
          children: [
            Chart(expenses: widget.expenseData), 
            const SizedBox( height: 20,),
            Expanded(child: expenseCardhelper(expenseData: widget.expenseData, deleteExpense: deleteExpense,))

          ],
        ): Row(children: [
            Expanded(child: Chart(expenses: widget.expenseData)), 
            const SizedBox( height: 20,),
            Expanded(child: expenseCardhelper(expenseData: widget.expenseData, deleteExpense: deleteExpense,))

        ],);
    }
    return Scaffold(
       backgroundColor:const Color.fromARGB(255, 145, 160, 170), 
      appBar: AppBar(
        title: Text('Expenses Screen', style: GoogleFonts.comfortaa(fontSize: 25.0),),
         backgroundColor:const  Color(0xFF58656D),
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){
            showModalBottomSheet(context: context, isScrollControlled: true,builder: (context) =>  expensesLayover(addExpense: addingExpense,), useSafeArea: true);
          }, icon: const Icon(Icons.add, color: Colors.white,)),
          const SizedBox(width: 10.0,),
          
        ],
        ),
        body: mainExpenseScreen
       
    );
  }
}