import 'package:flutter/material.dart';
import 'dropdown_rating_form_field.dart';
import '../components/arguments.dart';
import '../db/journal_entry_dto.dart';
import '../db/database_manager.dart';
import '../screens/journal_entry_list.dart';

class JournalEntryForm extends StatefulWidget {
  final Arguments arguments;
  JournalEntryForm({this.arguments});
  @override
  _JournalEntryFormState createState() => _JournalEntryFormState();
}

class _JournalEntryFormState extends State<JournalEntryForm> {
  final formKey = GlobalKey<FormState>();
  final journalEntryValues = JournalEntryDTO();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: formContent(context),
    );
  }

  Widget formContent(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          titleTextField(),
          SizedBox(
            height: 10,
          ),
          bodyTextField(),
          SizedBox(
            height: 10,
          ),
          ratingDropDown(),
          SizedBox(
            height: 10,
          ),
          buttons(context),
        ],
      ),
    );
  }

  Widget titleTextField() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
        labelText: 'Title',
        border: OutlineInputBorder(),
      ),
      onSaved: (value) {
        journalEntryValues.title = value;
      },
      validator: (value) {
        return value.isEmpty ? 'Please enter a title' : null;
      },
    );
  }

  Widget bodyTextField() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
        labelText: 'Body',
        border: OutlineInputBorder(),
      ),
      onSaved: (value) {
        journalEntryValues.body = value;
      },
      validator: (value) {
        return value.isEmpty ? 'Please enter some text' : null;
      },
    );
  }

  Widget ratingDropDown() {
    return DropdownRatingFormField(
        maxRating: 4,
        validator: (value) {
          return (value < 1 || value > 5)
              ? 'Please choose a value between 1-4'
              : null;
        },
        onSaved: (value) {
          journalEntryValues.rating = value;
        });
  }

  Widget buttons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        cancelButton(context),
        saveButton(context),
      ],
    );
  }

  Widget cancelButton(BuildContext context) {
    return RaisedButton(
        child: Text('Cancel'), onPressed: () => Navigator.of(context).pop());
  }

  Widget saveButton(BuildContext context) {
    return RaisedButton(
      child: Text('Save'),
      onPressed: () async {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          addDateToJournalEntryValues();
          final databaseManager = DatabaseManager.getInstance();
          databaseManager.saveJournalEntry(dto: journalEntryValues);
          Arguments arguments = widget.arguments;
          Navigator.of(context)
              .pushNamed(JournalEntryList.routeName, arguments: arguments);
          ;
        }
      },
    );
  }

  void addDateToJournalEntryValues() {
    journalEntryValues.dateTime = DateTime.now();
  }
}
