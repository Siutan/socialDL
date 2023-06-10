import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final String title;
  final String body;
  final String openText;

  const DialogBox({
    Key? key,
    required this.title,
    required this.body,
    required this.openText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: Text(openText),
    );
  }
}
