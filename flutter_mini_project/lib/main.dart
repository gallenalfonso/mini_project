import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/transaction.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'my_app.dart';

void main() async{

  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());

  await Hive.openBox<Transaction>('transaction');
  runApp( const MyApp());
}


/*NOTE :
1. Tambah ROutes
2. Tambah Provider
*/