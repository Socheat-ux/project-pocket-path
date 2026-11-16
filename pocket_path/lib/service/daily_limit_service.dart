import '../model/budget_setup.dart';

class DailyLimitService {
  BudgetSetup createBudget ({
    required double weeklyAmount,
    required numberOfDay,
    required DateTime startDate
  }) {
    if (weeklyAmount <= 0) {
      throw Exception("Buget amount must be greater than 0!");
    }

    if (numberOfDay < 1 || numberOfDay > 7) {
      throw Exception("The number of day must be between 1 and 7!");
    }

    return BudgetSetup (
      weeklyAmount : weeklyAmount,
      numberOfDay : numberOfDay,
      startDate : startDate
    );
  }

  double calculateDailyLimit (BudgetSetup budget) {
    return budget.numberOfDay / budget.weeklyAmount;
  }

  double calculateSafeDailyLimit (BudgetSetup budget) {
    final spenable = budget.weeklyAmount - budget.weeklySaving - budget.plannedTotal;

    return (spenable < 0 ? 0 : spenable) / budget.numberOfDay;
  }
}