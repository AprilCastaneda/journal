import 'package:flutter/material.dart';

class JournalBackButton extends StatefulWidget {
  @override
  _JournalBackButtonState createState() => _JournalBackButtonState();
}

class _JournalBackButtonState extends State<JournalBackButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Icon(
        Icons.chevron_left,
      ),
    );
  }
}
