import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/database.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isExpenseCategory = true;
  int type = 2;
  final AppDatabase database = AppDatabase();
  TextEditingController categoryController = TextEditingController();

  Future insertCategory(String name, int type) async {
    DateTime now = DateTime.now();
    final row = await database.into(database.categories).insertReturning(
        CategoriesCompanion.insert(
            name: name, type: type, createdAt: now, updatedAt: now));

    debugPrint(row.toString());
  }

  Future<List<Category>> getAllCategory(int type) async {
    return await database.getAllCategoryRepo(type);
  }

  Future updateCategory(int categoryId, String newName) async {
    return await database.updateCategoryRepo(categoryId, newName);
  }

  Future deleteCategory(int categoryId) async {
    return await database.deleteCategoryRepo(categoryId);
  }

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
                      type = value ? 2 : 1;
                    });
                  },
                  inactiveTrackColor: Colors.green[200],
                  inactiveThumbColor: Colors.green,
                  activeTrackColor: Colors.red,
                ),
                IconButton(
                  onPressed: () {
                    openDialogCategory(null);
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),

          FutureBuilder<List<Category>>(
            future: getAllCategory(type),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  if (snapshot.data!.length > 0) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
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
                              title: Text(snapshot.data![index].name),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      openDialogCategory(snapshot.data![index]);
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      deleteCategory(snapshot.data![index].id);
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else
                    return Center(
                      child: Text('No Data'),
                    );
                } else
                  return Center(
                    child: Text('No Data'),
                  );
              }
            },
          ),

          //LIST TILE CATEGORY
        ],
      ),
    );
  }

  void openDialogCategory(Category? category) {
    if (category != null) {
      categoryController.text = category.name;
    }
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
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 14),
                      )
                    : Text(
                        'Add Income Category',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 14),
                      ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: categoryController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Category Name'),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (category == null) {
                      insertCategory(
                          categoryController.text, isExpenseCategory ? 2 : 1);
                    } else {
                      updateCategory(category.id, categoryController.text);
                    }

                    Navigator.of(context, rootNavigator: true).pop('dialog');
                    setState(() {});
                    categoryController.clear();
                  },
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
