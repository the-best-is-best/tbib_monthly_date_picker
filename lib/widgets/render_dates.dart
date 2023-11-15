/// ***
/// This class consists of the DateWidget that is used in the ListView.builder
///
/// Author: Vivek Kaushik <me@vivekkasuhik.com>
/// github: https://github.com/iamvivekkaushik/
/// ***

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tbib_monthly_date_picker/tap/tap.dart';

class DateWidget extends StatelessWidget {
  final double? width;
  final DateTime date;
  final TextStyle? dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback? onDateSelected;
  final String? locale;
  final List<DateTime> datesHasEvent;

  const DateWidget(
      {super.key,
      required this.date,
      // required this.monthTextStyle,
      required this.dayTextStyle,
      required this.dateTextStyle,
      required this.selectionColor,
      this.width,
      this.onDateSelected,
      this.locale,
      required this.datesHasEvent});

  @override
  Widget build(BuildContext context) {
    log("DateWidget.build $date");
    return InkWell(
      child: Container(
        width: width,
        margin: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: selectionColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                  DateFormat("E", locale).format(date).toUpperCase(), // WeekDay
                  style: dayTextStyle),
              const SizedBox(height: 10),
              Text(date.day.toString(), // Date
                  style: dateTextStyle),
              const SizedBox(height: 10),
              for (var dateHasEvent in datesHasEvent) ...{
                if (dateHasEvent.year == date.year &&
                    dateHasEvent.month == date.month &&
                    dateHasEvent.day == date.day) ...{
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  )
                }
              }
            ],
          ),
        ),
      ),
      onTap: () {
        onDateSelected?.call(date);
      },
    );
  }
}
