import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/database_manager.dart';
import 'journal_entry_screen.dart';
import 'new_entry.dart';
import 'welcome.dart';
import '../widgets/journal_back_button.dart';
import '../widgets/journal_entry_column.dart';
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
    bool vertical = true;
    void Function() setTheme = widget.setTheme;
    SharedPreferences prefs = widget.prefs;
    Arguments arguments = ModalRoute.of(context).settings.arguments;
    if (setTheme == null) {
      setTheme = arguments.setTheme;
    }
    if (prefs == null) {
      prefs = arguments.prefs;
    }

    if (journal == null) {
      return loadingScreen(setTheme, prefs);
    } else {
      return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 500) {
            return verticalView(setTheme, prefs, vertical);
          } else {
            return horizontalView(setTheme, prefs, arguments, !vertical);
          }
        },
      );
    }
  }

  Widget loadingScreen(Function() setTheme, SharedPreferences prefs) {
    return JournalScaffold(
        title: 'Loading',
        child: Center(child: CircularProgressIndicator()),
        setTheme: setTheme,
        prefs: prefs);
  }

  Widget verticalView(
      Function() setTheme, SharedPreferences prefs, bool vertical) {
    var route = ModalRoute.of(context).settings.name;
    return JournalScaffold(
        lgd: (route == NewEntry.routeName ||
                route == JournalEntryScreen.routeName)
            ? JournalBackButton()
            : null,
        title: journal.isEmpty ? 'Welcome' : 'Journal Entries',
        child: journal.isEmpty
            ? Welcome()
            : journalList(context, setTheme, prefs, vertical),
        setTheme: setTheme,
        prefs: prefs,
        fab: addEntryFab(context));
  }

  Widget horizontalView(Function() setTheme, SharedPreferences prefs,
      Arguments arguments, bool vertical) {
    var route = ModalRoute.of(context).settings.name;
    return JournalScaffold(
        lgd: (route == NewEntry.routeName ||
                route == JournalEntryScreen.routeName)
            ? JournalBackButton()
            : null,
        title: journal.isEmpty ? 'Welcome' : 'Journal Entries',
        child: journal.isEmpty
            ? Welcome()
            : Row(children: [
                Flexible(
                    flex: 5,
                    child: journalList(context, setTheme, prefs, vertical)),
                Flexible(flex: 1, child: Text('')),
                Flexible(
                    flex: 5,
                    child: JournalEntryColumn(
                        journalEntry:
                            arguments?.journalEntry ?? journal.getEntry(0))),
              ]),
        setTheme: setTheme,
        prefs: prefs,
        fab: addEntryFab(context));
  }

  void pushJournalScreen(
      int index, Function() setTheme, SharedPreferences prefs, bool vertical) {
    final journalEntry = JournalEntry(
      id: journal.getEntry(index).id,
      title: journal.getEntry(index).title,
      body: journal.getEntry(index).body,
      rating: journal.getEntry(index).rating,
      dateTime: journal.getEntry(index).dateTime,
    );
    final arguments =
        Arguments(setTheme: setTheme, prefs: prefs, journalEntry: journalEntry);
    vertical
        ? Navigator.of(context)
            .pushNamed(JournalEntryScreen.routeName, arguments: arguments)
        : Navigator.of(context)
            .pushNamed(JournalEntryList.routeName, arguments: arguments);
  }

  Widget journalTile(
      int index, Function() setTheme, SharedPreferences prefs, bool vertical) {
    return ListTile(
        title: Text(journal.getEntry(index).title),
        subtitle: Text(DateFormat('EEEE, MMMM d, yyyy')
            .format(journal.getEntry(index).dateTime)),
        onTap: () => pushJournalScreen(index, setTheme, prefs, vertical));
  }

  Widget journalList(BuildContext context, Function() setTheme,
      SharedPreferences prefs, bool vertical) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: journal.numberOfEntries,
              itemBuilder: (context, index) {
                return journalTile(index, setTheme, prefs, vertical);
              }),
        ),
      ],
    );
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
