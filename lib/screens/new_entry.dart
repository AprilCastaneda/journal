import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/journal_drawer.dart';

class NewEntry extends StatefulWidget {
  final void Function() setTheme;
  final SharedPreferences prefs;
  static const routeName = 'newEntry';

  NewEntry({Key key, this.setTheme, this.prefs}) : super(key: key);

  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        endDrawer:
            JournalDrawer(setTheme: widget.setTheme, prefs: widget.prefs),
        appBar: AppBar(
          title: Text('New Journal Entry'),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.keyboard_arrow_left),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.settings,
                ),
                onPressed: () => scaffoldKey.currentState.openEndDrawer(),
              ),
            ),
          ],
        ),
        body: Center(
            child: Column(
          children: [],
        )));
  }
}
