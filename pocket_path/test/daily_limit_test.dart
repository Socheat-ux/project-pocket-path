import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_path/model/budget_setup.dart';
import 'package:pocket_path/model/savings_goal.dart';
import 'package:pocket_path/service/daily_limit_service.dart';
import 'package:pocket_path/service/planned_purchase_service.dart';
import 'package:pocket_path/service/savings_service.dart';

void main() {
  test('normal: 70 / 7 = 10', () {
    final DailyLimitService limitService = DailyLimitService();

    final BudgetSetup budget = limitService.createBudget(
        weeklyAmount: 70, numberOfDay: 7, startDate: DateTime(2026, 11, 16));

    expect(limitService.calculateDailyLimit(budget), 10);
  });

  test('invalid budget 0 is rejected', () {
    final DailyLimitService limitService = DailyLimitService();
    expect(
        () => limitService.createBudget(weeklyAmount: 0, numberOfDay: 7, startDate: DateTime(2026, 11, 16)),
        throwsException
    );
  });

  test('invalid 8 days is rejected', () {
    final DailyLimitService limitService = DailyLimitService();
    expect(
        () => limitService.createBudget(weeklyAmount: 70, numberOfDay: 8, startDate: DateTime(2026, 11, 16)),
        throwsException
    );
  });

  test('boundary: 1 day, whole budget is the limit', () {
    final DailyLimitService limitService = DailyLimitService();

    final BudgetSetup budget = limitService.createBudget(
        weeklyAmount: 70, numberOfDay: 1, startDate: DateTime(2026, 11, 16));

    expect(limitService.calculateDailyLimit(budget), 70);
  });

  test('savings 14 + planned 14 -> safe limit 6', () {
    final DailyLimitService limitService = DailyLimitService();
    final SavingsService savingsService = SavingsService();
    final PlannedPurchaseService plannedService = PlannedPurchaseService();
    final DateTime start = DateTime(2026, 11, 16);

    final BudgetSetup budget = limitService.createBudget(weeklyAmount: 70, numberOfDay: 7, startDate: start);

    savingsService.setSavingGoal(budget, amount: 14, period: SavingsPeroid.weekly);
    plannedService.addPlannedPurchase(budget, name: 'Book', amount: 14, plannedDate: start);

    expect(limitService.calculateSafeDailyLimit(budget), 6);
  });
}