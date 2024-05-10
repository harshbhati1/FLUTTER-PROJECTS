import 'package:financeapp/Data/creditsData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class creditCard extends StatelessWidget {
  final Cred credit ; 
  const creditCard({required this.credit,super.key});

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
              Text(credit.title, style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$${credit.amount.toStringAsFixed(2)}', style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                  const Spacer(), 
                  Icon(credIcons[credit.category], color: Colors.white,),
                  const SizedBox(width: 5.0,),
                  Text(credit.formattedDate.toString(), style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
          
                ],
              )
                
            ],
          ),
        ),
      ),
    ) ;
  }
}