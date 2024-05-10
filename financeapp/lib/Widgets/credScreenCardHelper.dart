import 'package:financeapp/Data/creditsData.dart';
import 'package:financeapp/Widgets/credScreenCard.dart';
import 'package:flutter/material.dart';

class credCardhelper extends StatelessWidget {
  final void Function(Cred credot) deleteCredit;
  final List<Cred> creditData;
  const credCardhelper({ required this.deleteCredit,required this.creditData,super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: creditData.length,
    itemBuilder: (context, index) => Dismissible(key: ValueKey( creditCard(credit: creditData[index])), onDismissed: (direction) => deleteCredit(creditData[index]), background: Container(
      color: const Color.fromARGB(255, 196, 192, 192), margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    ),child: creditCard(credit: creditData[index])));
  }
}