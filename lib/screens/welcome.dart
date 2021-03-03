import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/new_entry.dart';
import '../widgets/journal_drawer.dart';

class Welcome extends StatefulWidget {
  static const routeName = 'welcome';
  Welcome({Key key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.book,
                color: Colors.pink,
                size: MediaQuery.of(context).size.height * .2,
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Journal', style: Theme.of(context).textTheme.headline6)
              ]),
        ),
      ],
    );
  }
}
