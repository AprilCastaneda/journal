import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_switch/flutter_switch.dart';

class JournalDrawer extends StatefulWidget {
  final void Function() setTheme;
  final SharedPreferences prefs;
  JournalDrawer({Key key, this.setTheme, this.prefs}) : super(key: key);

  @override
  _JournalDrawerState createState() => _JournalDrawerState();
}

class _JournalDrawerState extends State<JournalDrawer> {
  static const DARK_THEME_KEY = 'dark_theme';
  bool isDark;

  @override
  Widget build(BuildContext context) {
    isDark = widget.prefs.getBool(DARK_THEME_KEY);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .125,
            child: DrawerHeader(
              child: Text('Settings'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .01),
            child: SwitchListTile(
                title: const Text('Dark Mode'),
                value: !isDark,
                onChanged: (bool val) {
                  setState(() {
                    widget.prefs.setBool(DARK_THEME_KEY, !val);
                    widget.setTheme();
                  });
                }),
          ),
        ],
      ),
    );
  }
}
