import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/transactions.dart';

import 'models/boxes.dart';
import 'my_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionsAdapter());
  boxTransactions = await Hive.openBox<Transactions>('transactionsBox');
  runApp(const MyApp());
}


/*NOTE :
1. Tambah ROutes
2. Tambah Provider
*/