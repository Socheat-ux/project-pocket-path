
import 'package:pocket_path/model/daily_budget_summary.dart';
import 'package:pocket_path/service/daily_limit_service.dart';

class DashboardService {
  final DailyLimitService _limitService;

  DashboardService({DailyLimitService? limitService}) : _limitService = limitService ?? DailyLimitService();

  Expense addExpense({
    Budget budget,
    required double amount,
    required DateTime date,
    String category = 'Other',
    String? note,
  }) {
    if (amount <= 0) {
      throw Exception("Amount must be greater than 0!");
    }

    if (!budget.isInPeriod(date)) {
      throw Exception("Expense date is outside budget period!");
    }

    final expenses = Expense(
      id: DateTime.now(),
      amount : amount,
      date : date,
      category : category,
      note : note
    );

    budget.expenses.add(expenses);
    return expenses;
  }

  DailyBudgetSummary getDashboard(Budget budget, DateTime today) {
    final limit = _limitService.calculateDailyLimit(budget);
    final spendToday = budget.spendOn(today);
    final spenable = budget.weeklyAmount - budget.weeklySaving - budget.plannedTotal;

    return DailyBudgetSummary(
      spendToday: spendToday, 
      dailyLimit: limit, 
      remainWeeklyBudget: 
      budget.weeklyAmount - budget.weeklySaving, 
      saftToSpend: spenable - budget.totalSpend, 
      isOverSpending: spendToday > limit
    );

  }
}