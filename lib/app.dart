import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome.dart';

class App extends StatefulWidget {
  final String schemaSQL;
  final SharedPreferences prefs;

  const App({Key key, this.schemaSQL, this.prefs}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static const DARK_THEME_KEY = 'dark_theme';
  Brightness brightness;
  bool isDark;

  @override
  void initState() {
    super.initState();
    setTheme();
  }

  void setTheme() async {
    setState(() {
      isDark = widget.prefs.getBool(DARK_THEME_KEY);
      if (isDark == null) {
        isDark = false;
        brightness = Brightness.light;
        widget.prefs.setBool(DARK_THEME_KEY, isDark);
      } else if (isDark == true) {
        isDark = false;
        brightness = Brightness.light;
      } else {
        isDark = true;
        brightness = Brightness.dark;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome',
        theme: ThemeData(brightness: brightness),
        home: Welcome(setTheme: setTheme, prefs: widget.prefs));
    // title: 'Journal', theme: ThemeData.dark(), routes: routes);
  }
}
