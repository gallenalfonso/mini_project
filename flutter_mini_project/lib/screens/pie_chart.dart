import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShowCharts extends StatefulWidget {
  const ShowCharts({super.key});

  @override
  State<ShowCharts> createState() => _ShowChartsState();
}

class _ShowChartsState extends State<ShowCharts> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Overview'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Boxes.getTransaction().listenable(),
        builder: (context, box, _) {
          double totalIncome = 0;
          double totalExpense = 0;

          for (var transaction in box.values) {
            if (transaction.expenseIncome) {
              totalExpense += transaction.amount;
            } else {
              totalIncome += transaction.amount;
            }
          }

          double totalAmount = totalIncome - totalExpense;
          double totalAmountForPercentage = totalIncome + totalExpense;
          double incomePercentage =
              (totalIncome / totalAmountForPercentage) * 100;
          double expensePercentage =
              (totalExpense / totalAmountForPercentage) * 100;
          return Column(
            children: [
              //WIDGET PIE CHART

              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                  height: 200,
                  child: (PieChart(
                    // swapAnimationCurve: Curves.bounceIn,
                    swapAnimationDuration: const Duration(milliseconds: 950),
                    PieChartData(
                      sections: [
                        //ITEM 1
                        PieChartSectionData(
                          value: totalExpense,
                          color: Colors.red,
                          title:
                              'Expense \n ${(expensePercentage).toStringAsFixed(1)} %',
                          titlePositionPercentageOffset: 1.8,
                        ),
                        //ITEM 2
                        PieChartSectionData(
                          value: totalIncome,
                          color: Colors.green,
                          title:
                              'Income \n ${(incomePercentage).toStringAsFixed(1)} %',
                          titlePositionPercentageOffset: 1.8,
                        ),
                      ],
                    ),
                  )),
                ),
              ),

              SizedBox(
                height: 40,
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber[100],
                ),
                height: 170,
                width: 300,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'OVERALL',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        children: [
                          Text(
                            'Rp.  ',
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            width: 45,
                          ),
                          Text(
                            '${totalAmount.toInt()}',
                            style: TextStyle(fontSize: 26),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green[400],
                    ),
                    height: 100,
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_downward_sharp,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Income',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            'Rp ${totalIncome.toInt()}',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red[400]),
                    height: 100,
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_upward_sharp,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Expense',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            'Rp ${totalExpense.toInt()}',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
