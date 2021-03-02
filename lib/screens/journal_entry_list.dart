import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/database_manager.dart';
import 'journal_entry_screen.dart';
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
    void Function() setTheme = widget.setTheme;
    SharedPreferences prefs = widget.prefs;
    if (setTheme == null) {
      Arguments arguments = ModalRoute.of(context).settings.arguments;
      setTheme = arguments.setTheme;
    }
    if (prefs == null) {
      Arguments arguments = ModalRoute.of(context).settings.arguments;
      prefs = arguments.prefs;
    }

    if (journal == null) {
      return JournalScaffold(
          title: 'Loading',
          child: Center(child: CircularProgressIndicator()),
          setTheme: setTheme,
          prefs: prefs);
    } else {
      return JournalScaffold(
          title: journal.isEmpty ? 'Welcome' : 'Journal Entries',
          child: journal.isEmpty
              ? Welcome()
              : journalList(context, setTheme, prefs),
          setTheme: setTheme,
          prefs: prefs,
          fab: addEntryFab(context));
    }
  }

  Widget journalList(
      BuildContext context, Function() setTheme, SharedPreferences prefs) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              // shrinkWrap: true,
              itemCount: journal.numberOfEntries,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(journal.getEntry(index).title),
                    subtitle: Text(DateFormat('EEEE, MMMM d, yyyy')
                        .format(journal.getEntry(index).dateTime)),
                    onTap: () {
                      final arguments = Arguments(
                          setTheme: setTheme,
                          prefs: prefs,
                          title: journal.getEntry(index).title,
                          body: journal.getEntry(index).body,
                          date: DateFormat('EEEE, MMMM d, yyyy')
                              .format(journal.getEntry(index).dateTime),
                          rating: journal.getEntry(index).rating.toString());
                      Navigator.of(context).pushNamed(
                          JournalEntryScreen.routeName,
                          arguments: arguments);
                    });
              }),
        ),
      ],
    );
    // return SingleChildScrollView(
    //   physics: ScrollPhysics(),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     mainAxisSize: MainAxisSize.max,
    //     children: [
    //       ListView.builder(
    //           physics: NeverScrollableScrollPhysics(),
    //           shrinkWrap: true,
    //           itemCount: journal.numberOfEntries,
    //           itemBuilder: (context, index) {
    //             return ListTile(
    //                 title: Text(journal.getEntry(index).title),
    //                 subtitle: Text(DateFormat('EEEE, MMMM d, yyyy')
    //                     .format(journal.getEntry(index).dateTime)),
    //                 onTap: () {
    //                   final arguments = Arguments(
    //                       setTheme: widget.setTheme,
    //                       prefs: widget.prefs,
    //                       title: journal.getEntry(index).title,
    //                       body: journal.getEntry(index).body,
    //                       date: DateFormat('EEEE, MMMM d, yyyy')
    //                           .format(journal.getEntry(index).dateTime),
    //                       rating: journal.getEntry(index).rating.toString());
    //                   Navigator.of(context).pushNamed(
    //                       JournalEntryScreen.routeName,
    //                       arguments: arguments);
    //                 });
    //           }),
    //     ],
    //   ),
    // );
  }

  FloatingActionButton addEntryFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => displayJournalEntryForm(context),
      child: Icon(Icons.add),
    );
  }

  void displayJournalEntryForm(BuildContext context) {
    final arguments = Arguments(setTheme: widget.setTheme, prefs: widget.prefs);
    Navigator.of(context).pushNamed(NewEntry.routeName, arguments: arguments);
  }
}
