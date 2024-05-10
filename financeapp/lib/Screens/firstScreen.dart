import 'package:financeapp/Data/creditsData.dart';
import 'package:financeapp/Data/expensesData.dart';
import 'package:financeapp/Screens/creditsScreen.dart';
import 'package:financeapp/Screens/expensesScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class firstScreen extends StatefulWidget {
  
  const firstScreen({super.key});

  @override
  State<firstScreen> createState() => _firstScreenState();
}

class _firstScreenState extends State<firstScreen> {
  DateTime currentTime = DateTime.now();
  String welcomeMessage = 'Good Evening!';
  String welcomeImage = 'evening.gif';


  // data 
  List<Cred> creditData = [];

  List<Exp> expenseData = [
   
  ];

  // data add and delete credit 
void addCredit (Cred credit){
  setState(() {
    creditData.add(credit);
  });
  
}

void deleteCredit (Cred credit){
  setState(() {
    creditData.remove(credit);
  });

}

void insertCredit(int index, Cred credit){
  setState(() {
    creditData.insert(index, credit);
  });
  
}

  // data add and delete expense
  void addExpense (Exp expense){
    setState(() {
      expenseData.add(expense);
    });}
    void deleteExpense(Exp expense){
    setState(() {
      expenseData.remove(expense);
    });
  }
  void insertExpense(int index, Exp expense){
    setState(() {
      expenseData.insert(index, expense);
    });
  }


  // data closes
  
  
  @override
  Widget build(BuildContext context) {
    

   ///////// // logic /////////////////
   

   // logic for daytime
 if(currentTime.hour>4 && currentTime.hour<12){
      welcomeMessage = 'Good Morning';
      welcomeImage = 'day1.jpeg';
} else if (currentTime.hour>=12 && currentTime.hour<17){
  welcomeMessage = 'Good Afternoon';
  welcomeImage = 'afternoon.gif';
}

// logic for total amount 

// creditsum
double credSum = 0.0;
for (int i = 0;i<creditData.length;i++){
  credSum+=creditData[i].amount;
}

//expenseSum
double expenseSum = 0.0;
for (int i = 0;i<expenseData.length;i++){
  expenseSum+=expenseData[i].amount;
}

double totalsum = credSum - expenseSum;







// actual screenCode

    return Scaffold(
      
      appBar: AppBar(
        title:  Text('Expenses Bees', style: GoogleFonts.comfortaa(fontSize: 30.0) ,),
        backgroundColor:const Color(0xFF58656D),
        foregroundColor: Colors.white,
      ),
      backgroundColor:const Color.fromARGB(255, 126, 137, 143),
      body: SingleChildScrollView(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 300,
               decoration: BoxDecoration(
                image:DecorationImage(image:  AssetImage('assets/$welcomeImage'), fit: BoxFit.cover)),
                child: Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50.0,),
                  Text(welcomeMessage,  style: GoogleFonts.urbanist(fontSize: 30, color:  Colors.white, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 1,),
                   Text("Mr. Bhati",  style: GoogleFonts.urbanist(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w600))
                ],
              ),),
            ),
            const SizedBox(height: 50.0,),
            Center(child:  Text("Your total balance is \$${totalsum.toStringAsFixed(2)}", style: GoogleFonts.breeSerif(fontSize: 20, color: Colors.white),),),
            const SizedBox(height: 20.0,),
             Center(child: Text("How can we help you?", style: GoogleFonts.urbanist(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500),) ,),
            const SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              
              children: [
                const SizedBox(width: 50.0,),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> expensesScreen(expenseData: expenseData,insetExpense: insertExpense,addExpense: addExpense,delteExpense: deleteExpense,)));
                }, style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFFF19E8E) ),child: Text('Add Expenses', style: GoogleFonts.urbanist(fontSize: 15, color:  Colors.white, fontWeight: FontWeight.w700) )),
        
                const Spacer(),
        
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> creditsScreen(addCredit: addCredit, deleteCredit: deleteCredit,insertCredit: insertCredit,creditData: creditData,)));
                }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF19E8E)),child:  Text('Add Credits', style: GoogleFonts.urbanist(fontSize: 15,color: Colors.white, fontWeight: FontWeight.w700))),
        
                const SizedBox(width: 50.0,),
              ],
            )
        
            
        
        
          ],
        ),
      ),
    );
  }
}