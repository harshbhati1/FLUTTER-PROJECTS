import 'package:financeapp/Data/creditsData.dart';
import 'package:flutter/material.dart';
import 'expenseChart_bar.dart';


class creditChart extends StatelessWidget {
  const creditChart({super.key, required this.credit});

  final List<Cred> credit;

  List<creditBucket> get buckets {
    return [
      creditBucket.forCategory(credit, CredCategories.work),
      creditBucket.forCategory(credit, CredCategories.gifts),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalCredit > maxTotalExpense) {
        maxTotalExpense = bucket.totalCredit;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF19E8E),
            Color.fromARGB(255, 248, 209, 201)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.totalCredit == 0
                        ? 0
                        : bucket.totalCredit / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        credIcons[bucket.Category],
                        color: Colors.white
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
