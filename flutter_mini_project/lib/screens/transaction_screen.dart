import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  bool isExpenseCategory = true;
  List categoryList = ['Makan', 'Nonton', 'Pulsa'];
  late String dropDownValue = categoryList.first;
  TextEditingController dateController = TextEditingController();

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

              //DROPDOWN BUTTON CATEGORY
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<String>(
                  value: dropDownValue,
                  isExpanded: true,
                  icon: Icon(Icons.arrow_downward),
                  items: categoryList.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {},
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
                        DateFormat('dd-MM-yyyy').format(selectDate);

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
              onPressed: () {},
              child: Text('SAVE'),
            ),
          ),
        ],
      ),
    );
  }
}