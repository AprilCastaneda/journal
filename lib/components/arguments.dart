import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/journal_entry.dart';

class Arguments {
  final void Function() setTheme;
  final SharedPreferences prefs;
  final JournalEntry journalEntry;
  Arguments({Key key, this.setTheme, this.prefs, this.journalEntry});
}
