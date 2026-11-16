
import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_path/model/budget_setup.dart';
import 'package:pocket_path/model/savings_goal.dart';
import 'package:pocket_path/service/daily_limit_service.dart';
import 'package:pocket_path/service/planned_purchase_service.dart';
import 'package:pocket_path/service/savings_service.dart';

void main() {
  test('planned purchase lower than the safty limit', () {
    final DailyLimitService limitService = DailyLimitService();
    final PlannedPurchaseService plannedPurchaseService = PlannedPurchaseService();
    final DateTime start = DateTime(2020, 11, 20);
    final BudgetSetup budget = limitService.createBudget(
        weeklyAmount: 70, numberOfDay: 7, startDate: start);

    plannedPurchaseService.addPlannedPurchase(budget, name: 'Book', amount: 28, plannedDate: start);

    expect(limitService.calculateDailyLimit(budget), 6);
  });

  test('planned purchase exceed the budget', () {
    final DailyLimitService limitService = DailyLimitService();
    final PlannedPurchaseService plannedPurchaseService = PlannedPurchaseService();
    final SavingsService savingsService = SavingsService();
    final DateTime start = DateTime(2020, 11, 20);
    final BudgetSetup budget = limitService.createBudget(
        weeklyAmount: 70, numberOfDay: 7, startDate: start);

    savingsService.setSavingGoal(budget, amount: 50, period: SavingsPeroid.weekly);

    expect(
      () =>  plannedPurchaseService.addPlannedPurchase(budget, name: 'Shoes', amount: 25, plannedDate: start), 
      throwsException
    );
  });

  test('empty name is rejected', () {
    final DailyLimitService limitService = DailyLimitService();
    final PlannedPurchaseService plannedPurchaseService = PlannedPurchaseService();
    final DateTime start = DateTime(2020, 11, 20);
    final BudgetSetup budget = limitService.createBudget(
        weeklyAmount: 70, numberOfDay: 7, startDate: start);


    expect(
      () => plannedPurchaseService.addPlannedPurchase(budget, name: ' ', amount: 28, plannedDate: start), 
      throwsException
    );
  });

  test('planned purchase that fills the budget exactly is allowed', () {
    final DailyLimitService limitService = DailyLimitService();
    final PlannedPurchaseService plannedPurchaseService = PlannedPurchaseService();
    final SavingsService savingsService = SavingsService();
    final DateTime start = DateTime(2020, 11, 20);
    final BudgetSetup budget = limitService.createBudget(
        weeklyAmount: 70, numberOfDay: 7, startDate: start);

    savingsService.setSavingGoal(budget, amount: 20, period: SavingsPeroid.weekly);
    plannedPurchaseService.addPlannedPurchase(budget, name: 'Skincare', amount: 50, plannedDate: start);

    expect(limitService.calculateDailyLimit(budget), 0);
  });

  test('markPaid, record the real expense and keep limit stable', () {
    final DailyLimitService limitService = DailyLimitService();
    final PlannedPurchaseService plannedPurchaseService = PlannedPurchaseService();
    final DateTime start = DateTime(2020, 11, 20);
    final BudgetSetup budget = limitService.createBudget(
        weeklyAmount: 70, numberOfDay: 7, startDate: start);

    final planned = plannedPurchaseService.addPlannedPurchase(budget, name: 'Skincare', amount: 28, plannedDate: start);
    plannedPurchaseService.markPaid(budget, planned.id);

    expect(budget.totalSpent, 28);
    expect(planned.isPaid, true);
    expect(limitService.calculateSafeDailyLimit(budget), 6);

  });

  test('record the same planned purchase twice is rejected', () {
    final DailyLimitService limitService = DailyLimitService();
    final PlannedPurchaseService plannedPurchaseService = PlannedPurchaseService();
    final DateTime start = DateTime(2020, 11, 20);
    final BudgetSetup budget = limitService.createBudget(
        weeklyAmount: 70, numberOfDay: 7, startDate: start);
    
    final planned = plannedPurchaseService.addPlannedPurchase(budget, name: 'Skincare', amount: 28, plannedDate: start);
    plannedPurchaseService.markPaid(budget, planned.id);

    expect(
      () => plannedPurchaseService.markPaid(budget, planned.id),
      throwsException
    );
    
  });
}