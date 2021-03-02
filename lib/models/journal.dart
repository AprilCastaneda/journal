import 'journal_entry.dart';

class Journal {
  List<JournalEntry> entries;
  Journal({this.entries});

  bool get isEmpty => entries.isEmpty;
  int get numberOfEntries => entries.length;
  JournalEntry getEntry(int index) => entries[index];
}
