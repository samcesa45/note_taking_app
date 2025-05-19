import 'package:intl/intl.dart';

String formatDate(DateTime? dateTime) {
  if (dateTime == null) {
    return 'N/A';
  }
  return DateFormat('yyyy-dd').format(dateTime);
}
