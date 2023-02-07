import 'package:intl/intl.dart';

class DateUtil {
  static String formatDateAsString(DateTime date) {
    DateFormat df = DateFormat("EEEEE d MMMM yyyy, HH:mm", "fr_CH");
    return df.format(date);
  }
}
