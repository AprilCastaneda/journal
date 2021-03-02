import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Arguments {
  final void Function() setTheme;
  final SharedPreferences prefs;
  final String title;
  final String body;
  final String date;
  final String rating;
  Arguments(
      {Key key,
      this.setTheme,
      this.prefs,
      this.title,
      this.body,
      this.date,
      this.rating});
}
