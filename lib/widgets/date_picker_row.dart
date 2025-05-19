import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerRow extends StatelessWidget {
  final DateTime selectedDate;
  final void Function(DateTime) onDateSelected;

  const DatePickerRow({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          final dayOffset = index - selectedDate.weekday + 1;
          final displayDate = selectedDate.add(Duration(days: dayOffset));
          final isSelected =
              displayDate.day == selectedDate.day &&
              displayDate.month == selectedDate.month &&
              displayDate.year == selectedDate.year;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () => onDateSelected(displayDate),
              child: Container(
                width: 50.0,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                  color: isSelected ? Colors.black : Colors.transparent,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('EEE').format(displayDate),
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              isSelected
                                  ? Colors.white
                                  : Theme.of(context).iconTheme.color,
                          fontFamily: 'Avenir',
                        ),
                      ),
                      Text(
                        DateFormat('d').format(displayDate),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color:
                              isSelected
                                  ? Colors.white
                                  : Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
