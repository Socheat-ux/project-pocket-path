class DailyLimitService {
  Budget createBudget ({
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

    return Budget (
      weeklyAmount : weeklyAmount,
      numberOfDay : numberOfDay,
      startDate : startDate
    );
  }

  double calculateDailyLimit (Budget budget) {
    return budget.numberOfDay / budget.weeklyAmount;
  }

  double calculateSafeDailyLimit (Budget budget) {
    final spenable = budget.weeklyAmount - budget.weeklySaving - budget.plannedTotal;

    return (spenable < 0 ? 0 : spenable) / budget.numberOfDay;
  }
}