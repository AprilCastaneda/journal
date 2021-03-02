import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Arguments {
  final void Function() setTheme;
  final SharedPreferences prefs;
  Arguments({Key key, this.setTheme, this.prefs});
}
