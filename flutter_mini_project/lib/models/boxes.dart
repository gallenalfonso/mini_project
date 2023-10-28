import 'package:flutter_mini_project/models/transaction.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  static Box<Transaction> getTransaction()=>Hive.box<Transaction>('transaction');
}