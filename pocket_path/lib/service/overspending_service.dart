import '../model/overspending_alert.dart';

class OverspendingService {

  OverspendingAlert? checkOverspending({
    required double spentToday,
    required double dailyLimit,
  }) {
    if (spentToday < 0) {
      throw ArgumentError('Spent amount cannot be negative.');
    }
    if (dailyLimit < 0) {
      throw ArgumentError('Daily limit cannot be negative.');
    }
    if (spentToday <= dailyLimit) return null;
    return OverspendingAlert(spentToday: spentToday, dailyLimit: dailyLimit);
  }

  double recalculateDailyLimit({
    required double remainingBalance,
    required int daysLeftAfterToday,
  }) {
    if (remainingBalance < 0) {
      throw ArgumentError('Remaining balance cannot be negative.');
    }
    if (daysLeftAfterToday <= 0) {
      throw StateError('No days left in the budget period to recalculate.');
    }
    return remainingBalance / daysLeftAfterToday;
  }
}
