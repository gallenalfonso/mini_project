import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/boxes.dart';
import 'package:flutter_mini_project/models/transaction.dart';
import 'package:flutter_mini_project/providers/homepage_provider.dart';
import 'package:flutter_mini_project/screens/transaction_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomepageProvider>(context, listen: false)
        .updateFilteredTransactions();
  }

  // @override
  // void dispose() {
  //   Hive.close();
  //   super.dispose();
  // }

  // void editTransaction(Transaction transaction, double amount,
  //     String description, DateTime dateTime, bool isExpenseCategory) {
  //   transaction.amount = amount;
  //   transaction.description = description;
  //   transaction.dateTime = dateTime;
  //   transaction.expenseIncome = isExpenseCategory;

  //   transaction.save();
  // }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomepageProvider>(context, listen: false);

    return Scaffold(
      appBar: CalendarAppBar(
        white: Colors.black,
        black: Colors.white,
        accent: Colors.amber,
        backButton: false,
        // onDateChanged: (value) => print(value),
        onDateChanged: (value) {
          homeProvider.selectDateLogic(value);
          homeProvider.updateTotals();
          debugPrint(value.toString());
        },
        firstDate: DateTime.now().subtract(const Duration(days: 140)),
        lastDate: DateTime.now(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TransactionScreen(),
          ));
        },
        child: Icon(Icons.add_sharp),
      ),
      body: ValueListenableBuilder<Box<Transaction>>(
        valueListenable: Boxes.getTransaction().listenable(),
        builder: (context, box, _) {
          final transactions = box.values.toList().cast<Transaction>();

          return buildContent(transactions);
        },
      ),
    );
  }

  Widget buildContent(List<Transaction> transactions) {
    final buildProvider = Provider.of<HomepageProvider>(context, listen: false);
    List<Transaction> filteredTransactions = transactions
        .where((transaction) =>
            transaction.dateTime.year == buildProvider.selectedDate.year &&
            transaction.dateTime.month == buildProvider.selectedDate.month &&
            transaction.dateTime.day == buildProvider.selectedDate.day)
        .toList();

    // if (transactions.isEmpty)
    if (filteredTransactions.isEmpty) {
      return const Center(
        child: Text(
          'No Transactions',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Consumer<HomepageProvider>(builder: (context, homeProvider, _) {
        return Column(
          children: [
            //TEXT OVERVIEW
            Center(
              child: Text(
                'Overview',
                style: TextStyle(fontSize: 22),
              ),
            ),

            ///OVERVIEW INCOME EXPENSE REKAP
            Padding(
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
                        homeProvider.totalIncome.toStringAsFixed(2),
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
                        homeProvider.totalExpense.toStringAsFixed(2),
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

            Consumer<HomepageProvider>(
                builder: (context, expandedTransactions, _) {
              return Expanded(
                  child: ListView.builder(
                // itemCount: transactions.length,
                itemCount: expandedTransactions.filteredTransactions.length,
                itemBuilder: (context, index) {
                  // final transaction = transactions[index];
                  final transaction =
                      expandedTransactions.filteredTransactions[index];

                  return buildTransaction(context, transaction);
                },
              ));
            })
          ],
        );
      });
    }
  }

  Widget buildTransaction(BuildContext context, Transaction transaction) {
    final homeProvider = Provider.of<HomepageProvider>(context, listen: false);
    // LIST TILE TRANSACTIONS

    if (homeProvider.filteredTransactions.contains(transaction)) {
      return Card(
        // color: Colors.white,
        child: ListTile(
          leading: transaction.expenseIncome
              ? Icon(
                  Icons.arrow_upward_sharp,
                  color: Colors.red,
                )
              : Icon(
                  Icons.arrow_downward_sharp,
                  color: Colors.green,
                ),
          title: Text(transaction.amount.toInt().toString()),
          subtitle: Text(transaction.description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  homeProvider.deleteTransaction(transaction);
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ),
      );
    }
    return Text('NO TRANSACTION TODAY');
  }
}
