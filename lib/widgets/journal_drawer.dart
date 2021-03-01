import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class JournalDrawer extends StatefulWidget {
  @override
  _JournalDrawerState createState() => _JournalDrawerState();
}

class _JournalDrawerState extends State<JournalDrawer> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .1,
            child: DrawerHeader(
              child: Text('Settings'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('Dark Mode'),
                ],
              ),
              Column(
                children: [
                  FlutterSwitch(
                      value: isDark,
                      showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          isDark = val;
                        });
                      }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
