class PlannedPurchase {
  final String id;
  final String name;
  final double amount;
  final DateTime plannedDate;
  bool isPaid;

  PlannedPurchase({required this.id, required this.name, required this.amount, required this.plannedDate, this.isPaid = false});
}