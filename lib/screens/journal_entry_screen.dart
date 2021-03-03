import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/arguments.dart';
import '../widgets/journal_back_button.dart';
import '../widgets/journal_entry_column.dart';
import '../widgets/journal_scaffold.dart';

class JournalEntryScreen extends StatefulWidget {
  static const routeName = 'journalEntryScreen';
  const JournalEntryScreen({Key key}) : super(key: key);

  @override
  _JournalEntryScreenState createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends State<JournalEntryScreen> {
  @override
  Widget build(BuildContext context) {
    final Arguments arguments = ModalRoute.of(context).settings.arguments;
    return JournalScaffold(
      title: DateFormat('EEEE, MMMM d, yyyy')
          .format(arguments.journalEntry.dateTime)
          .toString(),
      child: JournalEntryColumn(journalEntry: arguments.journalEntry),
      setTheme: arguments.setTheme,
      prefs: arguments.prefs,
      lgd: JournalBackButton(),
    );
  }
}
