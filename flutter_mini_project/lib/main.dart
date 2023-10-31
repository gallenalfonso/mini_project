import 'package:flutter/material.dart';
import 'package:flutter_mini_project/models/transaction.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'my_app.dart';

void main() async{

  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());

  await Hive.openBox<Transaction>('transaction');
  runApp( const MyApp());
}


