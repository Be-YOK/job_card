import 'package:flutter/material.dart';

Future<bool> twoButtonsAlertMessage(
    context, String title, String content) async {
  bool yes = false;
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            yes = true;
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text('متأكد'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text('الغاء'),
        )
      ],
    ),
  );
  return yes;
}
