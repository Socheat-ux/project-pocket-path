import '../model/budget_setup.dart';
import '../model/expense.dart';
import '../model/planned_purchase.dart';

class PlannedPurchaseService {
  PlannedPurchase addPlannedPurchase(
    BudgetSetup budget, {
      required String name,
      required double amount,
      required DateTime plannedDate
  }) {
    if (name.isEmpty) {
      throw Exception("Name cannot be find!");
    }

    if (amount <= 0) {
      throw Exception("Amount must be greater than 0!");
    }

    if (!budget.isInPeriod(plannedDate)) {
      throw Exception("Planned date is outside the budget peroid!");
    }

    final total = budget.weeklySaving + budget.plannedTotal + amount;

    if (total > budget.weeklyAmount) {
      throw Exception("The Planned Purchase is exceed the available budget!");
    }

    final planned = PlannedPurchase(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name, 
      amount: amount, 
      plannedDate: plannedDate
    );

    budget.plannedPurchases.add(planned);
    return planned;
  }

  Expense markPaid(BudgetSetup budget, String plannedId) {
    final matches = budget.plannedPurchases.where((p) => p.id == plannedId);

    if (matches.isEmpty) {
      throw Exception("Planned Purchase not found!");
    }

    final planned = matches.first;
    if (planned.isPaid) {
      throw Exception("Planned Purchase is already paid!");
    }

    planned.isPaid = true;

    final expense = Expense(
      id : 'paid_${planned.id}',
      amount : planned.amount,
      date : planned.plannedDate,
      category : 'Planned',
      note : planned.name
    );

    budget.expenses.add(expense);
    return expense;
  }
}