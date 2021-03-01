import 'package:flutter/material.dart';

class JournalEntry extends StatelessWidget {
  final String title;
  final String body;
  final int rating;
  final DateTime dateTime;
  const JournalEntry(
      {Key key, this.title, this.body, this.rating, this.dateTime})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Nothing yet'),
    );
  }
}
