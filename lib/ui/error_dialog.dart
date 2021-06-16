import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String text;
  const ErrorDialog(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Text(text),
        actions: [
          TextButton(onPressed: () {Navigator.pop(context);}, child: Text("Ok")),
        ]
    );
  }
}
