import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class JournalDrawer extends StatefulWidget {
  @override
  _JournalDrawerState createState() => _JournalDrawerState();
}

class _JournalDrawerState extends State<JournalDrawer> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
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
                  value: _isDark,
                  onChanged: (val) {
                    setState(() {
                      _isDark = val;
                    });
                  })),
        ],
      ),
    );
  }
}
