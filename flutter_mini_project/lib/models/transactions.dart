import 'package:hive/hive.dart';

part 'transactions.g.dart';

@HiveType(typeId: 1)
class Transactions {
  @HiveField(0)
  int amount;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime dateTime;

  @HiveField(3)
  bool expenseIncome;

  Transactions(
      {required this.amount,
      required this.description,
      required this.dateTime,
      required this.expenseIncome});
}
