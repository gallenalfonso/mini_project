import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/boxes.dart';
import 'package:flutter_mini_project/models/transaction.dart';
import 'package:flutter_mini_project/viewmodel/providers/homepage_provider.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomepageProvider>(context, listen: false)
        .updateFilteredTransactions();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomepageProvider>(context, listen: false)
          .selectDateLogic(DateTime.now());
      Provider.of<HomepageProvider>(context, listen: false).updateTotals();
    });
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
        accent: Colors.teal[300],
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
            const Center(
              child: Text(
                'Overview',
                style: TextStyle(fontSize: 22),
              ),
            ),

            ///OVERVIEW INCOME EXPENSE REKAP
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Row(
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
                        NumberFormat.currency(
                                locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                            .format(
                          homeProvider.totalIncome,
                        ),
                        style: const TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Row(
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
                        NumberFormat.currency(
                                locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                            .format(homeProvider.totalExpense),
                        style: const TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //TRANSACTION TEXT
            const Padding(
              padding: EdgeInsets.only(top: 16.0, left: 16),
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
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Slidable(
          endActionPane: ActionPane(motion: const StretchMotion(), children: [
            SlidableAction(
              onPressed: (context) {
                homeProvider.deleteTransaction(transaction);
              },
              icon: Icons.delete,
              backgroundColor: Colors.red,
            )
          ]),
          child: Card(
            color: Colors.white,
            shadowColor: Colors.white,
            elevation: 0.9,
            child: ListTile(
              leading: transaction.expenseIncome
                  ? const Icon(
                      Icons.arrow_upward_sharp,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.arrow_downward_sharp,
                      color: Colors.green,
                    ),
              title: Text(
                NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(transaction.amount),
              ),
              subtitle: Text(transaction.description, style: const TextStyle()),
            ),
          ),
        ),
      );
    }
    return const Text('NO TRANSACTION TODAY');
  }
}
