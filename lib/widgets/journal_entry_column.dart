import 'package:flutter/material.dart';
import '../models/journal_entry.dart';

class JournalEntryColumn extends StatefulWidget {
  JournalEntry journalEntry;
  JournalEntryColumn({Key key, this.journalEntry}) : super(key: key);
  @override
  _JournalEntryColumnState createState() => _JournalEntryColumnState();
}

class _JournalEntryColumnState extends State<JournalEntryColumn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          journalEntryTitle(context),
          journalEntryBody(context),
          journalEntryRating(context),
        ],
      ),
    );
  }

  Widget journalEntryPadding(BuildContext context, List<Widget> textList) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .01,
          horizontal: MediaQuery.of(context).size.width * .05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: textList,
      ),
    );
  }

  Widget journalEntryTitle(BuildContext context) {
    return journalEntryPadding(context, [
      Text(widget.journalEntry.title,
          style: Theme.of(context).textTheme.headline5),
    ]);
  }

  Widget journalEntryBody(BuildContext context) {
    return journalEntryPadding(context, [
      Text(widget.journalEntry.body,
          style: Theme.of(context).textTheme.subtitle1),
    ]);
  }

  Widget journalEntryRating(BuildContext context) {
    return journalEntryPadding(context, [
      Text('Rating: ', style: Theme.of(context).textTheme.bodyText1),
      Text(widget.journalEntry.rating.toString(),
          style: Theme.of(context).textTheme.bodyText1),
    ]);
  }
}
