import 'package:intl/intl.dart';

//Gets Date on ISO 8610 format and display in a nicer version
String formatISOTime(String isoTime) {
  try {
    DateTime dateTime = DateTime.parse(isoTime);
    int day = dateTime.day;
    int today = DateTime.now().day;

    DateFormat formatter;
    if (day == today) {
      formatter = DateFormat('HH:mm:ss');
    } else {
      formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    }

    return formatter.format(dateTime);
  } catch (e) {
    return 'Invalid date format';
  }
}
