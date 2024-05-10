import 'package:financeapp/Data/creditsData.dart';
import 'package:financeapp/Data/expensesData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class creditLayover extends StatefulWidget {
  final void Function(Cred credit) addCredit;
  const creditLayover({ required this.addCredit, super.key});

  @override
  State<creditLayover> createState() => _creditLayoverState();
}

class _creditLayoverState extends State<creditLayover> {




   var _selectedCategory = CredCategories.work;
   // controllers for taking input 
    final _textController = TextEditingController();
    final _amountController = TextEditingController();
    DateTime? dateNtime ;

   void datepicker() async{
    final Now = DateTime.now();
    final firstdate = DateTime(Now.year-1, Now.month, Now.day);
     var date =  await showDatePicker(context: context, firstDate: firstdate, lastDate: Now);
     setState(() {
       dateNtime = date;
     });
   }


   // submiting data 
void submitCreditData(){
  var realAmount = double.tryParse(_amountController.text);
  var isCorrectAmount = realAmount==null || realAmount<=0;

  if(_textController.text.trim().isEmpty || isCorrectAmount || dateNtime == null ){
    showDialog(context: context, builder: (context) => AlertDialog(
       backgroundColor: const  Color(0xFFF19E8E),
      title:  Text("Invalid Input", style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 17, fontWeight: FontWeight.w400)),
      content:  Text("Please input valid title, amount and date",  style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 17, fontWeight: FontWeight.w400)),
      actions: [
        TextButton(onPressed: (){ Navigator.pop(context);}, child: Text("Okay",  style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 20, fontWeight: FontWeight.w700)))
      ],
      

    ));
    return;
  }
  widget.addCredit(Cred(title: _textController.text, amount: realAmount, date: dateNtime!, category: _selectedCategory));
  Navigator.pop(context);
}

   // dispose method 
   @override
  void dispose() {
    // TODO: implement dispose
    _textController.dispose();
    _amountController.dispose();
    super.dispose();
  }


 // actual code 
  @override
  Widget build(BuildContext context) {
    var keybaord = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 145, 160, 170)
      ),
      child: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(15.0,15.0,15.0,keybaord+15.0),
              child: Column(
                children: [
                 TextField(
                   style: const TextStyle(color: Colors.white),
                  controller: _textController,
                    maxLength: 50,
                    decoration: InputDecoration(
                      label: Text("Title", style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  Row(
                    children: [
                       Expanded(child: 
                      TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: _amountController,
                        decoration: InputDecoration(
                          prefixText: '\$',
                          label: Text("Amount", style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                        ),
                      )
                      ), 
                       const  SizedBox(width: 10.0,),
                      Expanded(child: Container(
                        margin:const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                        child: Row(
                          children: [
                            Text(dateNtime == null? 'Please select a date' : formatter.format(dateNtime!).toString(), style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                            const SizedBox(width: 2.0,),
                            IconButton(onPressed: datepicker , icon: const Icon(Icons.calendar_month, color: Colors.white,)),
                          ],
                        ),
                      ))
                    ],
                   
                  ), const SizedBox(height: 20.0,),
                  Row(
                    children: [
                      DropdownButton(dropdownColor: const Color.fromARGB(255, 182, 195, 204),value: _selectedCategory ,items: CredCategories.values.map((credcat) => DropdownMenuItem(value: credcat,child: Text(credcat.name.toUpperCase(), style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 20, fontWeight: FontWeight.w700)) )).toList() ,
                       onChanged: (value){
                        setState(() {
                          if(value==null){
                            return;
                          }
                          _selectedCategory = value;
                        });
              
                       }),
                      const Spacer(),
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, style: TextButton.styleFrom(backgroundColor: const Color(0xFFF19E8E)),child:  Text("Cancel", style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 15, fontWeight: FontWeight.w700))),
                       const SizedBox(width: 10.0,),
                      ElevatedButton(onPressed: submitCreditData,style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF19E8E)) ,child:  Text("Save", style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 15, fontWeight: FontWeight.w700)), ),
                        const SizedBox(width: 2,),
                    ],
                  )
                ],
                
              ),
            ),
          ),
        ),
      ),
    );
  }
}