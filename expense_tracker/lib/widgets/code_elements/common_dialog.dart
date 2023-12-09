import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showMyCupertinoDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (ctx) => CupertinoAlertDialog(
      title: const Text('Invalid input'),
      content:
          const Text('Please make sure that you entered everything correctly.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
          },
          child: const Text('Okay'),
        ),
      ],
    ),
  );
}

void showMyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Invalid input'),
      content:
          const Text('Please make sure that you entered everything correctly.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
          },
          child: const Text('Okay'),
        ),
      ],
    ),
  );
}
