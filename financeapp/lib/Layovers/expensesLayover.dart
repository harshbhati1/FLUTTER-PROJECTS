import 'package:financeapp/Data/expensesData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class expensesLayover extends StatefulWidget {
  final void Function(Exp expense) addExpense;
  const expensesLayover({required this.addExpense,super.key});

  @override
  State<expensesLayover> createState() => _expensesLayoverState();
}

class _expensesLayoverState extends State<expensesLayover> {

  // items to add 
  final _textController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _textController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void submitData(){
    var realAmount = double.tryParse(_amountController.text);
    var isValidAmount = realAmount==null || realAmount<=0;

    if(_textController.text.trim().isEmpty || isValidAmount || dateNtime == null){
      showDialog(context: context, builder: (context) => AlertDialog(
        backgroundColor: const  Color(0xFFF19E8E),
        title:  Text("Invalid Input",  style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 17, fontWeight: FontWeight.w400)) ,
        content: Text("Please make sure that you have entered correct title, amount and date.", style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 17, fontWeight: FontWeight.w400)),
        actions: [
          TextButton(onPressed: (){Navigator.pop(context);} , child: Text("Okay", style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 20, fontWeight: FontWeight.w700)))
        ], 

      ));
      return;
    } setState(() {
       widget.addExpense(Exp(title: _textController.text, amount: realAmount, date: dateNtime!, category: _selectedCategory));
    });
   
Navigator.pop(context);
  }
  DateTime? dateNtime;
  void datePicker () async{
    final Now = DateTime.now();
    final firstDate = DateTime(Now.year-1, Now.month,Now.day);
    var date = await showDatePicker(context: context, firstDate: firstDate, lastDate: Now);
    setState(() {
      dateNtime = date;
    });

  }
   var _selectedCategory = Categories.work;

  @override
  Widget build(BuildContext context) {
    var keyboard = MediaQuery.of(context).viewInsets.bottom ;
    return  Container(
      decoration:const  BoxDecoration(
        color: Color.fromARGB(255, 145, 160, 170)
      ),
      child: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15.0,15.0,15.0, keyboard+15.0),
              child:  Column(
                  children: [
                    TextField(
                      controller: _textController,
                      maxLength: 50,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        label: Text("Title",  style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                      ),),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _amountController,
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              decoration:  InputDecoration(
                                prefixText: '\$',
                                label: Text("Amount", style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ),
                         const  SizedBox(width: 10.0,),
                         Expanded(child: Container(
                          margin:const  EdgeInsets.fromLTRB(0.0,20.0,0.0,0.0),
                           child: Row(
                            children: [
                                Text(dateNtime == null ? 'Please pick a date': formatter.format(dateNtime!).toString(), style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                               const SizedBox(width: 2.0,),
                              IconButton(onPressed: datePicker, icon: const Icon(Icons.calendar_month, color: Colors.white,)),
                            ],
                           ),
                         ))
                
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          DropdownButton(dropdownColor: const Color.fromARGB(255, 182, 195, 204),value: _selectedCategory,
                          items: Categories.values.map((cat) => DropdownMenuItem(value: cat,child: Text(cat.name.toUpperCase(),style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 20, fontWeight: FontWeight.w700) ) )).toList(), 
                          onChanged: (value){
                            setState(() {
                              
                              if (value==null){
                                return;
                              }
                              _selectedCategory = value;
                            });
                          }),
                          const Spacer(),
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, style: TextButton.styleFrom(backgroundColor: const Color(0xFFF19E8E)),child:  Text("Cancel", style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 15, fontWeight: FontWeight.w700)), ),
                          const SizedBox(width: 10.0,),
                          ElevatedButton(onPressed: submitData, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF19E8E)) ,child:  Text("Save", style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 15, fontWeight: FontWeight.w700))),
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