
class DailyBudgetSummary {
  final double spendToday;
  final double dailyLimit;
  final double remainWeeklyBudget;
  final double safeToSpend;
  final bool isOverSpending;

  DailyBudgetSummary({required this.spendToday, required this.dailyLimit, required this.remainWeeklyBudget, required this.safeToSpend, required this.isOverSpending});

}