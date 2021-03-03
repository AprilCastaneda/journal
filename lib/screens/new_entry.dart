import 'package:flutter/material.dart';
import '../components/arguments.dart';
import '../widgets/journal_back_button.dart';
import '../widgets/journal_entry_form.dart';
import '../widgets/journal_scaffold.dart';

class NewEntry extends StatefulWidget {
  static const routeName = 'newEntry';

  NewEntry({Key key}) : super(key: key);

  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  @override
  Widget build(BuildContext context) {
    final Arguments arguments = ModalRoute.of(context).settings.arguments;
    return JournalScaffold(
      title: 'New Journal Entry',
      child: JournalEntryForm(arguments: arguments),
      setTheme: arguments.setTheme,
      prefs: arguments.prefs,
      lgd: JournalBackButton(),
    );
  }
}
