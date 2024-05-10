import 'package:financeapp/Data/creditsData.dart';
import 'package:financeapp/Layovers/creditLayover.dart';
import 'package:financeapp/Widgets/credScreenCardHelper.dart';
import 'package:financeapp/Widgets/creditChart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class creditsScreen extends StatefulWidget {
  final void Function(Cred credit) addCredit;
  final void Function(Cred credit) deleteCredit;
  final void Function(int index,Cred credit) insertCredit;
  final List<Cred> creditData;
  const creditsScreen({required this.addCredit, required this.deleteCredit,required this.insertCredit,required this.creditData,super.key});

  @override
  State<creditsScreen> createState() => _creditsScreenState();
}

class _creditsScreenState extends State<creditsScreen> {

  void deleteCredit(Cred credit){
    int index = widget.creditData.indexOf(credit);
setState(() {
  widget.deleteCredit(credit);
  });
ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Credit Deleted", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400)), 
  duration: const Duration(seconds: 3),
  backgroundColor: const Color(0xFFF19E8E),
  action: SnackBarAction(label: "Undo", textColor: Colors.white, onPressed: (){
    setState(() {
       widget.insertCredit(index,credit);
    });
   
  
  }),));
  }

  void addCredit(Cred credit){
    
    setState(() {
      widget.addCredit(credit);
    });

    
  }
  


 
// functions 

  @override
  Widget build(BuildContext context) {
    Widget mainCreditScrreen = Container(margin:const EdgeInsets.all(30),child: Center(child: Text("Seems like you don't have any Credit right now!", style:GoogleFonts.comfortaa(fontSize: 20.0, color:Colors.white ),)));
    if(widget.creditData.isNotEmpty){
      mainCreditScrreen =  Column(
        children: [
        creditChart(credit: widget.creditData),
          Expanded(child: credCardhelper(deleteCredit: deleteCredit,creditData: widget.creditData))
        ],
      );
    }
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 145, 160, 170),
      appBar: AppBar(
        title: Text('Credits Screen', style: GoogleFonts.comfortaa(fontSize: 25.0)),
        backgroundColor: const  Color(0xFF58656D),
        foregroundColor: Colors.white,
         actions: [
          IconButton(onPressed: (){
            showModalBottomSheet(context: context, isScrollControlled: true, builder: (context) => creditLayover(addCredit: addCredit,), useSafeArea: true);
          }, icon: const Icon(Icons.add, color: Colors.white,)),
          const SizedBox(width: 10.0,)
        ],
      ),
      body: mainCreditScrreen
     
    );
  }
}