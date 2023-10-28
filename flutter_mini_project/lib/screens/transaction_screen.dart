import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/boxes.dart';
import 'package:flutter_mini_project/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  bool isExpenseCategory = true;

  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    double.parse(amountController.text),
                    descriptionController.text,
                    DateTime.parse(dateController.text),
                    isExpenseCategory);

                Navigator.pop(context);
              },
              child: Text('SAVE'),
            ),
          ),
        ],
      ),
    );
  }
}
