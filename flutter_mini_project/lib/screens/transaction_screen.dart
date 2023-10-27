import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/boxes.dart';
import 'package:flutter_mini_project/models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatefulWidget {
  // final bool isEditing;
  // final Transactions transaction;
  // final Function(Transactions) onTransactionEdited;
  // final Function(Transactions) onTransactionAdded;

  // TransactionScreen({
  //   required this.isEditing,
  //   required this.transaction,
  //   required this.onTransactionEdited,
  //   required this.onTransactionAdded,
  // });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  bool isExpenseCategory = true;

  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();

  //   if (widget.isEditing) {
  //     // Populate input fields with the existing transaction data
      
  //     amountController.text = widget.transaction.amount.toString();
  //     descriptionController.text = widget.transaction.description;
  //     dateController.text =
  //         DateFormat('yyyy-MM-dd').format(widget.transaction.dateTime);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    void addTransaction(
        int amount, String description, DateTime dateTime, bool expenseIncome) {
      final transaction = Transactions(
          amount: int.parse(amountController.text),
          description: descriptionController.text,
          dateTime: DateTime.parse(dateController.text),
          expenseIncome: isExpenseCategory);

      boxTransactions.add(transaction);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //SWITCH BUTTON DAN DESCRIPTION
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Switch(
                      value: isExpenseCategory,
                      onChanged: (bool value) {
                        setState(() {
                          isExpenseCategory = value;
                        });
                      },
                      inactiveTrackColor: Colors.green[200],
                      inactiveThumbColor: Colors.green,
                      activeTrackColor: Colors.red,
                    ),
                    Text(
                      isExpenseCategory ? 'Expense' : 'Income',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Amount',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5),
                ),
              ),

              //TEXTFORMFIELD INPUT AMOUNT

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: amountController,
                  decoration: InputDecoration(
                    hintText: 'Input Nominal',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5),
                ),
              ),

              //DESCRIPTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Input Description',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),

          //DATE PICKER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
                readOnly: true,
                controller: dateController,
                decoration: InputDecoration(label: Text('Pick Date')),
                onTap: () async {
                  final selectDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1990),
                    lastDate: DateTime(2099),
                  );

                  if (selectDate != null) {
                    String formatDate =
                        DateFormat('yyyy-MM-dd').format(selectDate);

                    dateController.text = formatDate;
                  }
                }),
          ),

          SizedBox(
            height: 250,
          ),

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ElevatedButton(
              onPressed: () {
                addTransaction(
                    int.parse(amountController.text),
                    descriptionController.text,
                    DateTime.parse(dateController.text),
                    isExpenseCategory);
                Navigator.pop(context);

                // int newAmount = int.parse(amountController.text);
                // String newDescription = descriptionController.text;
                // DateTime newDateTime = DateTime.parse(dateController.text);
                // bool newExpenseIncome = widget.transaction.expenseIncome;

                // Transactions newTransaction = Transactions(
                //   amount: newAmount,
                //   description: newDescription,
                //   dateTime: newDateTime,
                //   expenseIncome: newExpenseIncome,
                // );

                // if (widget.isEditing) {
                //   // Pass the updated transaction back to the HomePage for editing in the Hive box
                //   widget.onTransactionEdited(newTransaction);
                // } else {
                //   // Pass the new transaction back to the HomePage for adding it to the Hive box
                //   widget.onTransactionAdded(newTransaction);
                // }
              },
              child: Text('SAVE'),
            ),
          ),
        ],
      ),
    );
  }
}
