import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/transaction_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CalendarAppBar(
        white: Colors.black,
        black: Colors.white,
        accent: Colors.amber,
        backButton: false,
        onDateChanged: (value) => print(value),
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.arrow_upward_sharp,
                      color: Colors.red,
                    ),
                    title: Text('20.000'),
                    subtitle: Text('Jajan'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.arrow_upward_sharp,
                      color: Colors.red,
                    ),
                    title: Text('20.000'),
                    subtitle: Text('Jajan'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
