import 'dart:io';

import 'package:expense_tracker/widgets/code_elements/common_dialog.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleControler = TextEditingController();
  final _amountControler = TextEditingController();
  DateTime? _selectedDate;
  Categoty _selectedCategory = Categoty.leisure;

  @override
  void dispose() {
    _titleControler.dispose();
    _amountControler.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    Platform.isIOS ? showMyCupertinoDialog(context) : showMyDialog(context);
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountControler.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleControler.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleControler.text,
        amount: enteredAmount,
        date: _selectedDate!,
        categoty: _selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width >= 600;
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.fromLTRB(16.0, 16.0, 16.0, keyboardSpace + 16.0),
              child: Column(
                children: [
                  if (isWideScreen)
                    _buildWideScreenUpperWidgets()
                  else
                    _buildTitleInput(),
                  if (isWideScreen)
                    _buildWideScreenLowerWidgets()
                  else
                    _buildAmountInputDate(),
                  const SizedBox(height: 16.0),
                  _buildButtons(isWideScreen),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWideScreenUpperWidgets() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextField(
            controller: _titleControler,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
        ),
        const SizedBox(
          width: 25.0,
        ),
        Expanded(
          child: TextField(
            controller: _amountControler,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixText: '\$',
              label: Text('Amount'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleInput() {
    return TextField(
      controller: _titleControler,
      maxLength: 50,
      decoration: const InputDecoration(
        label: Text('Title'),
      ),
    );
  }

  Widget _buildWideScreenLowerWidgets() {
    return Row(
      children: [
        DropdownButton(
          value: _selectedCategory,
          items: Categoty.values
              .map(
                (categoty) => DropdownMenuItem(
                  value: categoty,
                  child: Text(
                    categoty.name.toUpperCase(),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value == null) {
              return;
            }
            setState(() {
              _selectedCategory = value;
            });
          },
        ),
        const SizedBox(
          width: 25.0,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _selectedDate == null
                    ? 'No date selected'
                    : formatter.format(_selectedDate!),
              ),
              IconButton(
                onPressed: _presentDatePicker,
                icon: const Icon(
                  Icons.calendar_month,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAmountInputDate() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _amountControler,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixText: '\$',
              label: Text('Amount'),
            ),
          ),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _selectedDate == null
                    ? 'No date selected'
                    : formatter.format(_selectedDate!),
              ),
              IconButton(
                onPressed: _presentDatePicker,
                icon: const Icon(
                  Icons.calendar_month,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(bool isWideScreen) {
    return Row(
      children: [
        if (!isWideScreen) _buildCategoryDropdown(),
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitExpenseData,
          child: const Text('Save Expense'),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButton(
      value: _selectedCategory,
      items: Categoty.values
          .map(
            (categoty) => DropdownMenuItem(
              value: categoty,
              child: Text(
                categoty.name.toUpperCase(),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) {
          return;
        }
        setState(() {
          _selectedCategory = value;
        });
      },
    );
  }
}
