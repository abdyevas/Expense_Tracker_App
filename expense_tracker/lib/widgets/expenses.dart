import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Milk',
      amount: 3.99,
      date: DateTime.now(),
      categoty: Categoty.food,
    ),
    Expense(
      title: 'Gifts',
      amount: 39.99,
      date: DateTime.now(),
      categoty: Categoty.home,
    ),
    Expense(
      title: 'Tickets',
      amount: 170.5,
      date: DateTime.now(),
      categoty: Categoty.leisure,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ExpensesList(
              expenses: _registeredExpenses,
            ),
          ),
        ],
      ),
    );
  }
}
