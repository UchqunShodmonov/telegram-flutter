import 'package:jugger/jugger.dart' as j;

class DateParser {
  @j.inject
  DateParser();

  DateTime parseUnixTimeStampToDate(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(
          Duration(seconds: timestamp).inMilliseconds);
}

extension DateParserExtensions on DateParser {
  DateTime? parseUnixTimeStampToDateOrNull(int? timestamp) =>
      timestamp != null ? parseUnixTimeStampToDate(timestamp) : null;
}
