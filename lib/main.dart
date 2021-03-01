import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:path_provider/path_provider.dart';
import 'app.dart';
import 'db/database_manager.dart';

const SCHEMA_SQL_PATH = 'assets/schema_1.sql.txt';
const DARK_THEME = 'dark_theme';

void main() async {
  // Set orientations
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
  ]);
  // Get schema from txt file
  // Directory documentsDir = await getApplicationDocumentsDirectory();
  // String documentsPath = documentsDir.path;
  // final File file = File('$documentsPath/example.txt');
  // await file.writeAsString('Important data here!');

  String schemaSQL = await rootBundle.loadString(SCHEMA_SQL_PATH);

  await DatabaseManager.initialize();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(App(schemaSQL: schemaSQL, prefs: prefs));
}
