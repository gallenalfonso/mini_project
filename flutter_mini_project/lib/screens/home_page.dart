import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/boxes.dart';
import 'package:flutter_mini_project/screens/transaction_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_mini_project/models/boxes.dart';
import 'package:flutter_mini_project/models/transactions.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();

  List<Transactions> filterTransactions(DateTime selectedDate) {
    List<Transactions> filteredList = [];
    for (var transaction in boxTransactions.values) {
      if (transaction.dateTime.year == selectedDate.year &&
          transaction.dateTime.month == selectedDate.month &&
          transaction.dateTime.day == selectedDate.day) {
        filteredList.add(transaction);
      }
    }

    // boxTransactions.put('filtered_transactions_key', filteredList);
    return filteredList;
  }

  // void editTransaction(Transactions transactions, int amount,
  //     String description, DateTime dateTime, bool expenseIncome) {
  //   transactions.amount = amount;
  //   transactions.description = description;
  //   transactions.dateTime = dateTime;
  //   transactions.expenseIncome = expenseIncome;

  //   boxTransactions.put('key_${amountController}', updatedTransaction);

  //   // boxTransactions.save();
  // }

  void editTransaction(int index, int newAmount, String newDescription,
      DateTime newDateTime, bool newExpenseIncome) {
    if (index >= 0 && index < boxTransactions.length) {
      Transactions existingTransaction = boxTransactions.getAt(index);

      // Update the properties of the existing transaction
      existingTransaction.amount = newAmount;
      existingTransaction.description = newDescription;
      existingTransaction.dateTime = newDateTime;
      existingTransaction.expenseIncome = newExpenseIncome;

      // Save the updated transaction back to the box
      boxTransactions.putAt(index, existingTransaction);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Transactions> filteredTransactions = filterTransactions(selectedDate);
    return Scaffold(
      appBar: CalendarAppBar(
        white: Colors.black,
        black: Colors.white,
        accent: Colors.amber,
        backButton: false,
        onDateChanged: (value) {
          setState(() {
            selectedDate = value;
            debugPrint(value.toString());
          });
        },
        firstDate: DateTime.now().subtract(const Duration(days: 140)),
        lastDate: DateTime.now(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (context) => TransactionScreen(),
          ))
              .then((value) {
            setState(() {});
          });
        },
        // onPressed: () {
        //   Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => TransactionScreen(
        //       isEditing: false,
        //       transaction: Transactions(
        //         amount: 0,
        //         description: '',
        //         dateTime: DateTime.now(),
        //         expenseIncome: true,
        //       ),
        //       onTransactionEdited: (editedTransaction) {
        //         // Not used in add mode, you can pass an empty function or null here
        //       },
        //       onTransactionAdded: (newTransaction) {
        //         boxTransactions.add(newTransaction);
        //         Navigator.pop(context);
        //         setState(() {});
        //       },
        //     ),
        //   ));
        // },
        child: Icon(Icons.add_sharp),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TEXT OVERVIEW
              Center(
                child: Text(
                  'Overview',
                  style: TextStyle(fontSize: 22),
                ),
              ),

              ///OVERVIEW INCOME EXPENSE REKAP
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_downward_sharp,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Income',
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        Text(
                          '3.000.000',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_upward_sharp,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Expense',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Text(
                          '5.000.000',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //TRANSACTION TEXT
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16),
                child: Text(
                  'Transactions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              // LIST TILE TRANSACTIONS
              ListView.builder(
                shrinkWrap: true,
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  Transactions transaction = filteredTransactions[index];

                  return Card(
                    child: ListTile(
                      leading: (transaction.expenseIncome)
                          ? Icon(
                              Icons.arrow_upward_sharp,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.arrow_downward_sharp,
                              color: Colors.green,
                            ),
                      title: (transaction.expenseIncome)
                          ? Text(transaction.amount.toString(),
                              style: TextStyle(color: Colors.red))
                          : Text(transaction.amount.toString(),
                              style: TextStyle(color: Colors.green)),
                      subtitle: Text(transaction.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: ()
                                 {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TransactionScreen(),
                                    ),
                                  );
                                },

                            //     {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => TransactionScreen(
                            //         isEditing:
                            //             true, // Indicate that it's an edit operation
                            //         transaction: transaction,
                            //         onTransactionEdited: (editedTransaction) {
                            //           // Update the transaction in the Hive box
                            //           boxTransactions.putAt(
                            //               index, editedTransaction);
                            //           Navigator.pop(context);
                            //         },
                            //         onTransactionAdded: (newTransaction) {
                            //           // Not used in edit mode, you can pass an empty function or null here
                            //         },
                            //       ),
                            //     ),
                            //   );
                            // },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                boxTransactions.deleteAt(index);
                              });
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
