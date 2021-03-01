import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome.dart';

class App extends StatefulWidget {
  final String schemaSQL;
  final Brightness brightness;

  const App({Key key, this.schemaSQL, this.brightness}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome',
        // theme: ThemeData(brightness: brightness),
        home: Welcome());
    // title: 'Journal', theme: ThemeData.dark(), routes: routes);
  }
}
