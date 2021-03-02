class JournalEntryDTO {
  int id;
  String title;
  String body;
  int rating;
  DateTime dateTime;

  String toString() =>
      'ID: $id, Title: $title, Body: $body, Rating: $rating, Date: $dateTime';
}
