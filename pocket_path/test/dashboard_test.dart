
import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_path/model/budget_setup.dart';
import 'package:pocket_path/service/daily_limit_service.dart';
import 'package:pocket_path/service/dashboard_service.dart';

void main() {
  test('show spending today, limit and remaining', () {
    final DashboardService dashboardService = DashboardService();
    final DailyLimitService limitService = DailyLimitService();
    final DateTime start = DateTime(2020, 11, 10);
    final BudgetSetup budget = limitService.createBudget(
        weeklyAmount: 70, numberOfDay: 7, startDate: start);
    
    dashboardService.addExpense(budget, amount: 4, date: start);
    dashboardService.addExpense(budget, amount: 3, date: start);

    final summary = dashboardService.getDashboard(budget, start);

    expect(summary.spendToday, 7);
    expect(summary.dailyLimit, 10);
    expect(summary.remainWeeklyBudget, 63);
    expect(summary.isOverSpending, false);
  });

  test('spending exactly the limit not overspending', () {
    final DashboardService dashboardService = DashboardService();
    final DailyLimitService limitService = DailyLimitService();
    final DateTime start = DateTime(2020, 11, 10);
    final BudgetSetup budget = limitService.createBudget(
        weeklyAmount: 70, numberOfDay: 7, startDate: start);

    dashboardService.addExpense(budget, amount: 10, date: start);

    expect(dashboardService.getDashboard(budget, start).isOverSpending, false);
  });

  test('spending exactly the limit is overspending', () {
    final DashboardService dashboardService = DashboardService();
    final DailyLimitService limitService = DailyLimitService();
    final DateTime start = DateTime(2020, 11, 10);
    final BudgetSetup budget = limitService.createBudget(
        weeklyAmount: 70, numberOfDay: 7, startDate: start);

    dashboardService.addExpense(budget, amount: 10.5, date: start);

    expect(dashboardService.getDashboard(budget, start).isOverSpending, true);
  });

  test('expense outside budget period', () {
    final DashboardService dashboardService = DashboardService();
    final DailyLimitService limitService = DailyLimitService();
    final DateTime start = DateTime(2020, 11, 10);
    final BudgetSetup budget = limitService.createBudget(
        weeklyAmount: 70, numberOfDay: 7, startDate: start);

    expect(
      () => dashboardService.addExpense(budget, amount: 5, date: start.add(Duration(days: 7))),
      throwsException
    );
  });

  test('expense amount of 0', () {
    final DashboardService dashboardService = DashboardService();
    final DailyLimitService limitService = DailyLimitService();
    final DateTime start = DateTime(2020, 11, 10);
    final BudgetSetup budget = limitService.createBudget(
        weeklyAmount: 70, numberOfDay: 7, startDate: start);

    expect(
      () => dashboardService.addExpense(budget, amount: 0, date: start),
      throwsException
    );
  });
}