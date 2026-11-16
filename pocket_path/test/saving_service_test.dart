import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_path/model/budget_setup.dart';
import 'package:pocket_path/model/savings_goal.dart';
import 'package:pocket_path/service/daily_limit_service.dart';
import 'package:pocket_path/service/savings_service.dart';

void main() {
  test('weekly saving, reduce weekly spending amount', () {
    final DailyLimitService limitService = DailyLimitService();
    final SavingsService savingsService = SavingsService();
    final DateTime start = DateTime(2020, 11, 10);
    final BudgetSetup budget = limitService.createBudget(
        weeklyAmount: 70, numberOfDay: 7, startDate: start);

    savingsService.setSavingGoal(budget, amount: 20, period: SavingsPeroid.weekly);

    expect(savingsService.spenableAfterSaving(budget), 50);
    
  });

  test('saving 30 so 7 per week', () {
    final DailyLimitService limitService = DailyLimitService();
    final SavingsService savingsService = SavingsService();
    final DateTime start = DateTime(2020, 11, 10);
    final BudgetSetup budget = limitService.createBudget(
        weeklyAmount: 70, numberOfDay: 7, startDate: start);

    final SavingsGoal goal = savingsService.setSavingGoal(budget, amount: 30, period: SavingsPeroid.monthly);

    expect(goal.weeklyAmount, 7);
  });

  test('saving above the weekly budget suppose to be reject', () {
    final DailyLimitService limitService = DailyLimitService();
    final SavingsService savingsService = SavingsService();
    final DateTime start = DateTime(2020, 11, 10);
    final BudgetSetup budget = limitService.createBudget(
        weeklyAmount: 70, numberOfDay: 7, startDate: start);

    expect(
      () => savingsService.setSavingGoal(budget, amount: 71, period: SavingsPeroid.weekly),
      throwsException
    ); 
  });

  test('set saving the entire budget is fine', () {
    final DailyLimitService limitService = DailyLimitService();
    final SavingsService savingsService = SavingsService();
    final DateTime start = DateTime(2020, 11, 10);
    final BudgetSetup budget = limitService.createBudget(
        weeklyAmount: 70, numberOfDay: 7, startDate: start);

    expect(
      () => savingsService.setSavingGoal(budget, amount: 70, period: SavingsPeroid.weekly),
      returnsNormally
    ); 
  });
}