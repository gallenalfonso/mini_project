import 'package:flutter/material.dart';
import 'package:flutter_mini_project/viewmodel/providers/homepage_provider.dart';
import 'package:flutter_mini_project/viewmodel/providers/transaction_screen_provider.dart';
import 'package:flutter_mini_project/view/screens/home_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    final transactionProvider =
        Provider.of<TransactionScreenProvider>(context, listen: false);
    final homeProvider = Provider.of<HomepageProvider>(context, listen: false);
    final GlobalKey<FormState> formKeyProvider =
        Provider.of<TransactionScreenProvider>(context).formkey;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: Form(
        key: formKeyProvider,
        child: ListView(
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
                      Consumer<TransactionScreenProvider>(
                          builder: (context, switchButton, _) {
                        return Switch(
                          value: switchButton.isExpenseCategory,
                          onChanged: (bool value) {
                            switchButton.switchCategoryLogic(value);
                          },
                          inactiveTrackColor: Colors.green[200],
                          inactiveThumbColor: Colors.green,
                          activeTrackColor: Colors.red,
                        );
                      }),
                      Text(
                        transactionProvider.isExpenseCategory
                            ? 'Expense'
                            : 'Income',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),

                //TEXTFORMFIELD INPUT AMOUNT
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    validator: (value) {
                      return transactionProvider.validatorAmount(value);
                    },
                    controller: transactionProvider.amountController,
                    decoration: const InputDecoration(
                      hintText: 'Input Nominal',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Description',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5),
                  ),
                ),

                //DESCRIPTION
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    validator: (value) {
                      return transactionProvider.validatorDescription(value);
                    },
                    controller: transactionProvider.descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Input Description',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            //DATE PICKER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                  validator: (value) {
                    return transactionProvider.validatorDatePicker(value);
                  },
                  readOnly: true,
                  controller: transactionProvider.dateController,
                  decoration: const InputDecoration(label: Text('Pick Date')),
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

                      transactionProvider.dateController.text = formatDate;
                    }
                  }),
            ),

            const SizedBox(
              height: 250,
            ),

            Consumer<TransactionScreenProvider>(
                builder: (context, submitButton, _) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: ElevatedButton(
                  onPressed: () {
                    submitButton.saveTransactionButton();
                    Navigator.pop(context);
                    homeProvider.updateTotals();
                    homeProvider.updateFilteredTransactions();
                  },
                  child: const Text('SAVE'),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
