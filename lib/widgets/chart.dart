import 'package:expense_planner/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart({@required this.recentTransaction});

  List get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0;
      for (int i = 0; i < this.recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day && recentTransaction[i].date.month == weekDay.month && recentTransaction[i].date.year == weekDay.year) {
          totalSum = recentTransaction[i].amount + totalSum;
        }
      }
      return {'day': DateFormat('EEEE').format(weekDay).substring(0, 1), 'amount': totalSum};
    }).reversed.toList();
  }

  double get maxSpending {
    return recentTransaction.fold(0.0, (sum, item) => sum + item.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ...groupedTransactionValues.map((item) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: item['day'],
                  spendingAmount: item['amount'],
                  spendingPctOfTotal: maxSpending == 0 ? 0 : (item['amount'] as double) / maxSpending,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
