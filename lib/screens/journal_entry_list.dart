import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/database_manager.dart';
// import 'journal_entry.dart';
import 'new_entry.dart';
import 'welcome.dart';
import '../widgets/journal_scaffold.dart';
import '../models/journal.dart';
import '../models/journal_entry.dart';

class JournalEntryListScreen extends StatefulWidget {
  @override
  _JournalEntryListScreenState createState() => _JournalEntryListScreenState();
}

class _JournalEntryListScreenState extends State<JournalEntryListScreen> {
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

  // @override
  // Widget build(BuildContext context) {
  //   return JournalScaffold(
  //       title: journal.isEmpty ? 'Welcome' : 'Journal Entries',
  //       child: journal.isEmpty ? Welcome() : journalList(context),
  //       fab: addEntryFab(context));
  // }
  @override
  Widget build(BuildContext context) {
    if (journal == null) {
      return JournalScaffold(
          title: 'Loading', child: Center(child: CircularProgressIndicator()));
    } else {
      return JournalScaffold(
        title: journal.isEmpty ? 'Welcome' : 'Journal Entries',
        child: journal.isEmpty ? Welcome() : journalList(context);
        fab: addEntryFab(context)
      );
    }
  }

  Widget journalList(BuildContext context) {
    return ListView.builder(
        itemCount: journal.numberOfEntries,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(journal.getEntry(index).title),
            subtitle: Text(journal.getEntry(index).body),
            
          );
        });
  }

  FloatingActionButton addEntryFab(BuildContext context) {}

  void displayJournalEntryForm(BuildContext context) {}
}
