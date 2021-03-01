import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/journal_drawer.dart';

class JournalScaffold extends StatefulWidget {
  final void Function() setTheme;
  final SharedPreferences prefs;
  static const routeName = 'welcome';
  JournalScaffold({Key key, this.setTheme, this.prefs}) : super(key: key);

  @override
  _JournalScaffoldState createState() => _JournalScaffoldState();
}

class _JournalScaffoldState extends State<JournalScaffold> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      endDrawer: JournalDrawer(setTheme: widget.setTheme, prefs: widget.prefs),
      appBar: AppBar(
        title: Text('Welcome'),
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
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.book,
                    color: Colors.pink,
                    size: MediaQuery.of(context).size.height * .1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Journal',
                        style: Theme.of(context).textTheme.headline6)
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RaisedButton(
                    child: Icon(
                      Icons.add_circle_outlined,
                      size: MediaQuery.of(context).size.height * .075,
                    ),
                    onPressed: 
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
