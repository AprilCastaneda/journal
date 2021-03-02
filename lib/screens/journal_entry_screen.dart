import 'package:flutter/material.dart';
import '../components/arguments.dart';
import '../widgets/journal_scaffold.dart';

class JournalEntryScreen extends StatefulWidget {
  static const routeName = 'journalEntryScreen';
  const JournalEntryScreen({Key key}) : super(key: key);

  @override
  _JournalEntryScreenState createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends State<JournalEntryScreen> {
  @override
  Widget build(BuildContext context) {
    final Arguments arguments = ModalRoute.of(context).settings.arguments;
    return JournalScaffold(
      title: arguments.date ?? 'journal date empty',
      child: bodyColumn(context, arguments),
      setTheme: arguments.setTheme,
      prefs: arguments.prefs,
      lgd: leadingGestureDetector(context),
    );
  }

  Widget leadingGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Icon(
        Icons.chevron_left,
      ),
    );
  }

  Widget bodyColumn(BuildContext context, Arguments arguments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .01,
              horizontal: MediaQuery.of(context).size.width * .05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(arguments.title ?? 'journal title empty',
                  style: Theme.of(context).textTheme.headline5),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .01,
              horizontal: MediaQuery.of(context).size.width * .05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(arguments.body ?? 'journal body empty',
                  style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .01,
              horizontal: MediaQuery.of(context).size.width * .05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Rating: ', style: Theme.of(context).textTheme.bodyText1),
              Text(arguments.rating ?? 'journal rating empty',
                  style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
        ),
      ],
    );
  }
}
