import 'package:finance_expenses/datetime/date_time_helper.dart';
import 'package:finance_expenses/models/expenseitem.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  final List<Expenseitem> overallExpenseList = [];

  List<Expenseitem> getExpenseList() => overallExpenseList;

  void addExpense(Expenseitem expenseitem) {
    overallExpenseList.add(expenseitem);
    notifyListeners();
  }

  void removeExpense(Expenseitem expenseitem) {
    overallExpenseList.remove(expenseitem);
    notifyListeners();
  }

  static const List<String> _dayNames = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  String getDayName(DateTime dateTime) {
    return _dayNames[dateTime.weekday - 1];
  }

  DateTime startOfTheWeekDate() {
    final now = DateTime.now();
    return now.subtract(Duration(days: now.weekday % 7));
  }

  Map<String, double> calculateWeeklyExpense() {
    final Map<String, double> dailyExpense = {};
    final startOfWeek = startOfTheWeekDate();
    final endOfWeek = startOfWeek.add(const Duration(days: 7));

    for (var expense in overallExpenseList) {
      if (expense.dateTime.isAfter(startOfWeek) &&
          expense.dateTime.isBefore(endOfWeek)) {
        final date = ConvertdatetoString(expense.dateTime);
        final amount = double.tryParse(expense.amount) ?? 0.0;

        dailyExpense.update(date, (value) => value + amount,
            ifAbsent: () => amount);
      }
    }

    return dailyExpense;
  }
}
