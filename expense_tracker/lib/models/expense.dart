import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Categoty { food, travel, leisure, work, home }

const categoryIcons = {
  Categoty.food: Icons.lunch_dining_rounded,
  Categoty.travel: Icons.flight_sharp,
  Categoty.leisure: Icons.movie_creation,
  Categoty.work: Icons.work,
  Categoty.home: Icons.home,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.categoty,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categoty categoty;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(
    List<Expense> allExpenses,
    this.category,
  ) : expenses = allExpenses
            .where((expense) => expense.categoty == category)
            .toList();

  final Categoty category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
