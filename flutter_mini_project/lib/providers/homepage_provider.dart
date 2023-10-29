import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/boxes.dart';
import 'package:flutter_mini_project/models/transaction.dart';

class HomepageProvider extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();

  double totalIncome = 0;
  double totalExpense = 0;
  List<Transaction> filteredTransactions = [];

  void selectDateLogic(value) {
    selectedDate = value;
    updateFilteredTransactions();
    updateTotals();
    notifyListeners();
  }

  //TOTALIN
  void updateTotals() {
    final transactions = Boxes.getTransaction()
        .values
        .where((transaction) =>
            transaction.dateTime.year == selectedDate.year &&
            transaction.dateTime.month == selectedDate.month &&
            transaction.dateTime.day == selectedDate.day)
        .toList();

    double income = 0;
    double expense = 0;

    for (var transaction in transactions) {
      if (transaction.expenseIncome) {
        expense += transaction.amount;
      } else {
        income += transaction.amount;
      }
    }

    totalIncome = income;
    totalExpense = expense;
  }

  void deleteTransaction(Transaction transaction) {
    transaction.delete();
    notifyListeners();
    updateTotals();
    updateFilteredTransactions();
    notifyListeners();
    
  }

  void updateFilteredTransactions() {
    final transactions = Boxes.getTransaction()
        .values
        .where((transaction) =>
            transaction.dateTime.year == selectedDate.year &&
            transaction.dateTime.month == selectedDate.month &&
            transaction.dateTime.day == selectedDate.day)
        .toList();

    filteredTransactions = transactions;
  }
}
