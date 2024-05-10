import 'package:financeapp/Data/expensesData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class expenseCard extends StatelessWidget {
  final Exp expense; 
  const expenseCard({required this.expense,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    
      padding: const EdgeInsets.symmetric( horizontal: 30.0),
      child: Card(
        color: const Color(0xFFF19E8E),
       
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(expense.title, style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$${expense.amount.toStringAsFixed(2)}', style:  GoogleFonts.urbanist(color:  Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                  const Spacer(), 
                  Icon(categoriesIcon[expense.category], color:  Colors.white,),
                  const SizedBox(width: 5.0,),
                  Text(expense.formattedDate.toString(), style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
          
                ],
              )
                
            ],
          ),
        ),
      ),
    ) ;
  }
}