import 'package:expense_tracker/src/expenses/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

import '../model/expense.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final Function(Expense) onRemoveExpense;

  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          // color: Colors.blue, 도 가능함.
          color: Theme.of(context).colorScheme.error.withOpacity(0.7),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            vertical: Theme.of(context).cardTheme.margin!.vertical,
            // vertical: 5.0,  도 가능함.
          ),
        ),
        key: ValueKey(expenses[index]),
        // {void Function(DismissDirection)? onDismissed}
        // onDismissed: onRemoveExpense,  // error
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
