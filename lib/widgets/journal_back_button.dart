import 'package:flutter/material.dart';
import '../screens/welcome.dart';

class JournalBackButton extends StatefulWidget {
  @override
  _JournalBackButtonState createState() => _JournalBackButtonState();
}

class _JournalBackButtonState extends State<JournalBackButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var route = ModalRoute.of(context).settings.name;
        (route != Welcome.routeName) ? Navigator.of(context).pop() : null;
      },
      child: Icon(
        Icons.chevron_left,
      ),
    );
  }
}
