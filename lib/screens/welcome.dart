import 'package:flutter/material.dart';
import '../widgets/journal_drawer.dart';

class Welcome extends StatefulWidget {
  Welcome({Key key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      endDrawer: JournalDrawer(),
      appBar: AppBar(
        title: Text('Welcome'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.settings,
              ),
              onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.book,
                    color: Colors.pink,
                    size: MediaQuery.of(context).size.height * .1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Journal',
                        style: Theme.of(context).textTheme.headline6)
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
