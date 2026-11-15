# PocketPath — Smart Student Budget

Plan smarter. Spend better.

## About the Project

PocketPath is an offline personal budgeting mobile application designed to help students and individuals manage their money more effectively.

The application allows users to set weekly or monthly budgets, record income and expenses, plan upcoming purchases, and track savings goals. It also calculates recommended daily spending limits and alerts users when their daily expenses exceed their budget.

PocketPath helps users understand their spending habits, control unnecessary expenses, and make better financial decisions.

## Project Objectives

- Help users manage their weekly or monthly budgets.

- Track income and daily expenses.

- Calculate recommended daily spending limits.

- Notify users when they exceed their daily spending limit.

- Help users plan upcoming purchases before spending money.

- Encourage saving through savings targets.

- Allow users to review their previous spending activities.

## Main Features

| Feature | Description |
|---|---|
| Budget and Allowance Management| Set weekly or monthly budgets and manage available balances. |
| Daily Spending Entry | Record individual expenses or enter a combined daily spending total.|
| Automatic Daily Spending Limit|Calculate a recommended daily spending amount based on the remaining budget. |
| Immediate Overspending Alert | Display a warning when daily spending exceeds the spending limit. |
| Savings Planner | Set savings targets and track actual savings progress.|
| Planned Expenses | Plan upcoming purchases and reserve money for them.|
| Spending History | Review previous spending and monthly purchase totals.|
| Financial Dashboard | View remaining budget, daily spending, savings progress, and recent transactions. |


## Application Architecture

The project follows a layered structure:

- **Model**: Represents the application's business entities, such as Budget, Transaction, SavingsGoal, and PlannedPurchase.
- **Service**: Handles business logic, calculations, and validation.
- **Test**: Tests business operations and verifies expected results.


## Project Structure
```
pocket_path/

lib/
├── model/
├── service/
└── main.dart

test/
```
