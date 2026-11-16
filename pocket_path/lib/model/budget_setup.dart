import 'date_helper.dart';
import 'expense.dart';
import 'planned_purchase.dart';
import 'savings_goal.dart';

class BudgetSetup {
  final double weeklyAmount;
  final int numberOfDay;
  final DateTime startDate;

  final List<Expense> expenses = [];
  final List<PlannedPurchase> plannedPurchases = [];
  SavingsGoal? savingsGoal;

  BudgetSetup({
    required this.weeklyAmount,
    required this.numberOfDay,
    required DateTime startDate,
  }) : startDate = dateOnly(startDate);

  DateTime get endDate => DateTime.utc(
      startDate.year, startDate.month, startDate.day + numberOfDay - 1);

  bool isInPeriod(DateTime date) {
    final d = dateOnly(date);
    return !d.isBefore(startDate) && !d.isAfter(endDate);
  }

  double get weeklySaving => savingsGoal?.weeklyAmount ?? 0;

  double get plannedTotal =>
      plannedPurchases.fold(0.0, (sum, p) => sum + p.amount);

  double get unpaidPlannedTotal => plannedPurchases
      .where((p) => !p.isPaid)
      .fold(0.0, (sum, p) => sum + p.amount);

  double get totalSpent => expenses.fold(0.0, (sum, e) => sum + e.amount);

  double spentOn(DateTime date) {
    final d = dateOnly(date);
    return expenses
        .where((e) => e.date == d)
        .fold(0.0, (sum, e) => sum + e.amount);
  }
}
