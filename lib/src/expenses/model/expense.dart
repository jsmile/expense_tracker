import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();
// .yMD() is not constant, so we can't use it in the const constructor
// final DateFormat dateFormat = DateFormat.yMd();
final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

enum Category {
  food,
  travel,
  leisure,
  work,
}

// Map
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = const Uuid().v4();

  String get formattedDate => dateFormat.format(date);
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get categoryTotalExpenses {
    double sum = 0.0;
    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
