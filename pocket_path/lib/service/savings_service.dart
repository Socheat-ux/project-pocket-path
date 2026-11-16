import '../model/budget_setup.dart';
import '../model/savings_goal.dart';

class SavingsService {
  SavingsGoal setSavingGoal (
    BudgetSetup budget, {
      required double amount,
      required SavingsPeroid period
  }) {
    if (amount <= 0) {
      throw Exception("Amount must be greater than 0!");
    }

    final goal = SavingsGoal(amount: amount, peroid: period);

    if (goal.weeklyAmount + budget.plannedTotal > budget.weeklyAmount) {
      throw Exception("Saving goal exceed the available weekly budget!");
    }

    budget.savingsGoal = goal;
    return goal;
  }

  double spenableAfterSaving (BudgetSetup budget) => budget.weeklyAmount - budget.weeklySaving;

}