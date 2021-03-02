import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/journal_drawer.dart';

class JournalScaffold extends StatefulWidget {
  // static const routeName = 'welcome';
  // JournalScaffold({Key key, this.setTheme, this.prefs}) : super(key: key);

  final String title;
  final Widget child;
  final void Function() setTheme;
  final SharedPreferences prefs;
  final Widget fab;
  final Widget lgd;

  JournalScaffold(
      {Key key,
      this.title,
      this.child,
      this.setTheme,
      this.prefs,
      this.fab,
      this.lgd})
      : super(key: key);

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
        endDrawer:
            JournalDrawer(setTheme: widget.setTheme, prefs: widget.prefs),
        appBar: scaffoldAppBar(),
        body: Center(
          child: widget.child,
        ),
        floatingActionButton: widget.fab);
  }

  Widget scaffoldAppBar() {
    return AppBar(
      leading: widget.lgd,
      title: Text(widget.title),
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
    );
  }
}
