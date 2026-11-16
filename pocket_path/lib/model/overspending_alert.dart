
class OverspendingAlert {
  final double spentToday;
  final double dailyLimit;

  OverspendingAlert({required this.spentToday, required this.dailyLimit});

  double get exceededBy => spentToday - dailyLimit;
}
