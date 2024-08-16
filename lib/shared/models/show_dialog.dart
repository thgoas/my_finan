import 'package:flutter/material.dart';

class ShowDialog {
  static alertDialog(String title, String message, BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static confirmationAlertDialog(
      String title, String message, BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('sim', style: TextStyle(color: Colors.green)),
              onPressed: () {
                return Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text('não', style: TextStyle(color: Colors.red)),
              onPressed: () {
                return Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
