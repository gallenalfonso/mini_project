
import 'package:hive_flutter/hive_flutter.dart';

part 'transaction.g.dart';

@HiveType(typeId: 1)
class Transaction extends HiveObject{
  @HiveField(0)
  late double amount;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late DateTime dateTime;

  @HiveField(3)
  late bool expenseIncome;

 Transaction(
      {required this.amount,
      required this.description,
      required this.dateTime,
      required this.expenseIncome});

}