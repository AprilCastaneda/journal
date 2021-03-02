import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/database_manager.dart';
// import 'journal_entry.dart';
import 'new_entry.dart';
import 'welcome.dart';
import '../widgets/journal_scaffold.dart';
import '../models/journal.dart';
import '../models/journal_entry.dart';
import '../components/arguments.dart';

class JournalEntryList extends StatefulWidget {
  final void Function() setTheme;
  final SharedPreferences prefs;
  static const routeName = '/';
  JournalEntryList({Key key, this.setTheme, this.prefs}) : super(key: key);

  @override
  _JournalEntryListState createState() => _JournalEntryListState();
}

class _JournalEntryListState extends State<JournalEntryList> {
  Journal journal;

  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    final databaseManager = DatabaseManager.getInstance();
    List<JournalEntry> journalEntries = await databaseManager.journalEntries();
    setState(() {
      journal = Journal(entries: journalEntries);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (journal == null) {
      return JournalScaffold(
          title: 'Loading',
          child: Center(child: CircularProgressIndicator()),
          setTheme: widget.setTheme,
          prefs: widget.prefs);
    } else {
      return JournalScaffold(
          title: journal.isEmpty ? 'Welcome' : 'Journal Entries',
          child: journal.isEmpty ? Welcome() : journalList(context),
          setTheme: widget.setTheme,
          prefs: widget.prefs,
          fab: addEntryFab(context));
    }
  }

  Widget journalList(BuildContext context) {
    return ListView.builder(
        itemCount: journal.numberOfEntries,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(journal.getEntry(index).title),
            subtitle: Text(journal.getEntry(index).dateTime.toString()),
          );
        });
  }

  FloatingActionButton addEntryFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => displayJournalEntryForm(context),
      child: Icon(Icons.add_circle_outlined),
      backgroundColor: Colors.pink,
    );
  }

  void displayJournalEntryForm(BuildContext context) {
    final arguments = Arguments(setTheme: widget.setTheme, prefs: widget.prefs);
    Navigator.of(context).pushNamed(NewEntry.routeName, arguments: arguments);
  }
}
