import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/journal_drawer.dart';
import '../widgets/journal_entry_form.dart';
import '../widgets/journal_scaffold.dart';
import '../components/arguments.dart';

class NewEntry extends StatefulWidget {
  // final void Function() setTheme;

  // final SharedPreferences prefs;
  static const routeName = 'newEntry';

  NewEntry({Key key}) : super(key: key);

  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Arguments arguments = ModalRoute.of(context).settings.arguments;
    return JournalScaffold(
      title: 'New Journal Entry',
      child: JournalEntryForm(),
      setTheme: arguments.setTheme,
      prefs: arguments.prefs,
    );
  }
}
