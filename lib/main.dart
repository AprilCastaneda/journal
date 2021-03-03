import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'db/database_manager.dart';

const SCHEMA_SQL_PATH = 'assets/schema_1.sql.txt';
const DARK_THEME = 'dark_theme';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
  ]);
  String createSQL = await rootBundle.loadString(SCHEMA_SQL_PATH);

  await DatabaseManager.initialize(createSQL);

  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(App(prefs: prefs));
}
