import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/database.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final AppDatabase database = AppDatabase();
  bool isExpenseCategory = true;
  List categoryList = ['Makan', 'Nonton', 'Pulsa'];
  late String dropDownValue = categoryList.first;
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Category? selectedCategory;
  late int type;

  Future insertTransactions(
      int amount, DateTime date, String nameDescription, int categoryId) async {
    DateTime now = DateTime.now();
    final row = await database.into(database.transactions).insertReturning(
        TransactionsCompanion.insert(
            name: nameDescription,
            categoryId: categoryId,
            transactionDate: date,
            amount: amount,
            createdAt: now,
            updatedAt: now));
    debugPrint('Apa ini' + row.toString());
  }

  Future<List<Category>> getAllCategory(int type) async {
    return await database.getAllCategoryRepo(type);
  }

  @override
  void initState() {
    // TODO: implement initState
    type = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          type = (isExpenseCategory) ? 2 : 1;
                          selectedCategory = null;
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
                padding: const EdgeInsets.all(16.0),
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
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5),
                ),
              ),

              FutureBuilder(
                future: getAllCategory(type),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      if (snapshot.data!.length > 0) {
                        selectedCategory = snapshot.data!.first;
                        print(snapshot.data);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: DropdownButton<Category>(
                            value: (selectedCategory == null)
                                ? snapshot.data!.first
                                : selectedCategory,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_downward),
                            items: snapshot.data!
                                .map<DropdownMenuItem<Category>>(
                                    (Category item) {
                              return DropdownMenuItem<Category>(
                                value: item,
                                child: Text(item.name),
                              );
                            }).toList(),
                            onChanged: (Category? value) {
                              setState(() {
                                selectedCategory = value;
                              });
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: Text('No Data'),
                        );
                      }
                    } else {
                      return Center(
                        child: Text('No Category'),
                      );
                    }
                  }
                },
              ),

              //DROPDOWN BUTTON CATEGORY
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
            height: 10,
          ),

          //DESCRIPTION DETAILS TRANSACTION TEXTFORMFIELD
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
                keyboardType: TextInputType.name),
          ),

          SizedBox(
            height: 180,
          ),

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ElevatedButton(
              onPressed: () {
                insertTransactions(
                    int.parse(amountController.text),
                    DateTime.parse(dateController.text),
                    descriptionController.text,
                    selectedCategory!.id);
              },
              child: Text('SAVE'),
            ),
          ),
        ],
      ),
    );
  }
}
