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
    Arguments arguments = ModalRoute.of(context).settings.arguments;
    if (setTheme == null) {
      setTheme = arguments.setTheme;
    }
    if (prefs == null) {
      prefs = arguments.prefs;
    }

    if (journal == null) {
      return JournalScaffold(
          title: 'Loading',
          child: Center(child: CircularProgressIndicator()),
          setTheme: setTheme,
          prefs: prefs);
    } else {
      return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 500) {
            return JournalScaffold(
                title: journal.isEmpty ? 'Welcome' : 'Journal Entries',
                child: journal.isEmpty
                    ? Welcome()
                    : journalList(context, setTheme, prefs),
                setTheme: setTheme,
                prefs: prefs,
                fab: addEntryFab(context));
          } else {
            return JournalScaffold(
                title: journal.isEmpty ? 'Welcome' : 'Journal Entries',
                child: journal.isEmpty
                    ? Row(children: [Welcome()])
                    : Row(children: [
                        Flexible(
                            flex: 5,
                            child: journalListSmall(context, setTheme, prefs)),
                        Flexible(flex: 1, child: Text('')),
                        Flexible(
                            flex: 5, child: bodyColumn(context, arguments)),
                      ]),
                setTheme: setTheme,
                prefs: prefs,
                fab: addEntryFab(context));
          }
        },
      );
    }
  }

  Widget journalListSmall(
      BuildContext context, Function() setTheme, SharedPreferences prefs) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
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
                      final journalEntry = JournalEntry(
                        id: journal.getEntry(index).id,
                        title: journal.getEntry(index).title,
                        body: journal.getEntry(index).body,
                        rating: journal.getEntry(index).rating,
                        dateTime: journal.getEntry(index).dateTime,
                      );
                      final arguments = Arguments(
                          setTheme: setTheme,
                          prefs: prefs,
                          journalEntry: journalEntry);
                      Navigator.of(context).pushNamed(
                          JournalEntryList.routeName,
                          arguments: arguments);
                    });
              }),
        ),
      ],
    );
  }

  Widget journalList(
      BuildContext context, Function() setTheme, SharedPreferences prefs) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
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
                      final journalEntry = JournalEntry(
                        id: journal.getEntry(index).id,
                        title: journal.getEntry(index).title,
                        body: journal.getEntry(index).body,
                        rating: journal.getEntry(index).rating,
                        dateTime: journal.getEntry(index).dateTime,
                      );
                      final arguments = Arguments(
                          setTheme: setTheme,
                          prefs: prefs,
                          journalEntry: journalEntry);
                      Navigator.of(context).pushNamed(
                          JournalEntryScreen.routeName,
                          arguments: arguments);
                    });
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

  Widget bodyColumn(BuildContext context, Arguments arguments) {
    bool nullArgs = false;
    if (arguments == null || arguments.journalEntry == null) {
      nullArgs = true;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .01,
              horizontal: MediaQuery.of(context).size.width * .05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  nullArgs
                      ? journal.getEntry(0).title
                      : arguments.journalEntry.title,
                  style: Theme.of(context).textTheme.headline5),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .01,
              horizontal: MediaQuery.of(context).size.width * .05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  nullArgs
                      ? journal.getEntry(0).body
                      : arguments.journalEntry.body,
                  style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .01,
              horizontal: MediaQuery.of(context).size.width * .05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Rating: ', style: Theme.of(context).textTheme.bodyText1),
              Text(
                  nullArgs
                      ? journal.getEntry(0).rating.toString()
                      : arguments.journalEntry.rating.toString(),
                  style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
        ),
      ],
    );
  }
}
