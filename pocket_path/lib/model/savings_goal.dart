enum SavingsPeroid { weekly, monthly}

class SavingsGoal {
  final double amount;
  final SavingsPeroid peroid;

  SavingsGoal({required this.amount, required this.peroid});

  double get weeklyAmount => peroid == SavingsPeroid.weekly ? amount : amount * 7 / 30;

  
}