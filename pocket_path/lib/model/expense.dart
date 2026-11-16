import 'date_helper.dart';

class Expense {
  final String id;
  final double amount;
  final DateTime date;
  final String category;
  final String? note;

  Expense({
    required this.id,
    required this.amount,
    required DateTime date,
    this.category = 'Other',
    this.note,
  }) : date = dateOnly(date);
}
