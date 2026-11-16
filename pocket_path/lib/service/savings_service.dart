import 'package:pocket_path/model/savings_goal.dart';

class SavingsService {
  final SavingsGoal setSavingGoal (
    Budget budget, {
      required double amount,
      required SavingsPeroid period
  }) {
    if (amount <= 0) {
      throw Exception("Amount must be greater than 0!");
    }

    final goal = SavingsGoal(amount: amount, peroid: peroid);

    if (goal.weeklyAmount + budget.plannedTotal > budget.weeklyAmount) {
      throw Exception("Saving goal exceed the available weekly budget!");
    }

    budget.SavingsGoal.goal;
    return goal;
  }

  double spenableAfterSaving (Budget budget) => budget.weeklyAmount - budget.weeklySaving;

}