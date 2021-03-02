import 'package:flutter/material.dart';
import 'dropdown_rating_form_field.dart';
import '../db/journal_entry_dto.dart';
import '../db/database_manager.dart';

class JournalEntryForm extends StatefulWidget {
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
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
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
            ),
            SizedBox(
              height: 10,
            ),
            saveButton(context),
          ],
        ),
      ),
    );
  }

  Widget formContent(BuildContext context) {}

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

  Widget bodyTextField() {}

  Widget ratingDropDown() {}

  Widget buttons(BuildContext context) {}

  Widget cancelButton(BuildContext context) {}

  Widget saveButton(BuildContext context) {
    return RaisedButton(
      child: Text('Save'),
      onPressed: () async {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          addDateToJournalEntryValues();
          final databaseManager = DatabaseManager.getInstance();
          databaseManager.saveJournalEntry(dto: journalEntryValues);
          Navigator.of(context).pop();
        }
      },
    );
  }

  void addDateToJournalEntryValues() {
    journalEntryValues.dateTime = DateTime.now();
  }
}
