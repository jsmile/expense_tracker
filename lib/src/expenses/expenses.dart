import 'package:expense_tracker/src/expenses/new_expense.dart';
import 'package:flutter/material.dart';

import 'expense_list/expenses_list.dart';
import 'model/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    // 화면 하단에서 올라오는 모달창
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // ctx : showBottomSheet context
      // function 을 하위 위젯으로 전달하여, 하위 위젯에서 function 을 수행( 등록 )할 수 있도록 함.
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars(); // 기존 SnackBar 제거로 지연 표시 방지
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text('${expense.title} removed.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 그릴 때마다 mainContent 를 다시 그림  -> empty contents 검사 가능
    Widget mainContent = const Center(
      child: Text('No expense found. Start adding some.'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Chart'),
            Expanded(
              child: ExpensesList(
                expenses: _registeredExpenses,
                onRemoveExpense: _removeExpense,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: mainContent,
    );
  }
}
