import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isExpenseCategory = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: Column(
        children: [
          //SWITCH BUTTON DAN ADD BUTTON
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
                IconButton(
                  onPressed: () {
                    openDialogCategory();
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),

          //LIST TILE CATEGORY
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Card(
              child: ListTile(
                leading: isExpenseCategory
                    ? Icon(
                        Icons.arrow_upward_sharp,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.arrow_downward_sharp,
                        color: Colors.green,
                      ),
                title: Text('Makan'),
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

          
        ],
      ),
    );
  }

  void openDialogCategory() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                (isExpenseCategory)
                    ? Text(
                        'Add Expense Category',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red , fontSize: 14),
                      )
                    : Text(
                        'Add Income Category',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green, fontSize: 14),
                      ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Category Name'),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Save'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
