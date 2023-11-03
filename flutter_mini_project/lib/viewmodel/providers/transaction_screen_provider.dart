import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/boxes.dart';
import 'package:flutter_mini_project/models/transaction.dart';

class TransactionScreenProvider extends ChangeNotifier {
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey();

  bool isExpenseCategory = true;

  void switchCategoryLogic(value) {
    isExpenseCategory = value;
    notifyListeners();
  }

  String? validatorAmount(value) {
    if (value.isEmpty) {
      return 'Please Enter Amount';
    }
    notifyListeners();
    return null;
  }

  String? validatorDescription(value) {
    if (value.isEmpty) {
      return 'Please Enter Description';
    }
    notifyListeners();

    return null;
  }

  String? validatorDatePicker(value) {
    if (value.isEmpty) {
      return 'Please Select Date';
    }
    notifyListeners();
    return null;
  }

  void addTransaction(double amount, String description, DateTime dateTime,
      bool isExpenseCategory) {
    final transaction = Transaction(
        amount: amount,
        description: description,
        dateTime: dateTime,
        expenseIncome: isExpenseCategory);

    final box = Boxes.getTransaction();

    box.add(transaction);
  }

  void saveTransactionButton() {
    addTransaction(
        double.parse(amountController.text),
        descriptionController.text,
        DateTime.parse(dateController.text),
        isExpenseCategory);

    amountController.clear();
    descriptionController.clear();
    dateController.clear();

    notifyListeners();
  }
}
