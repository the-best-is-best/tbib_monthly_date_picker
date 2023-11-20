import 'package:flutter/material.dart';
import 'package:tbib_monthly_date_picker/extra/colors.dart';
import 'package:tbib_monthly_date_picker/extra/style.dart';

class DatePickerConfig {
  /// [dayTextStyle] is used to customize the style of the day in date picker
  final TextStyle dayTextStyle;

  /// [dayTextStyle] is used to customize the style of the day in date picker
  final TextStyle dateTextStyle;

  /// [selectedTextColor] is used to set the color of the selected date in date picker
  final Color selectedTextColor;

  /// [selectionColor] is used to set the color of the selected date in date picker
  final Color selectionColor;

  /// [deactivatedColor] is used to set the color of the dates that are not in the current month
  final Color deactivatedColor;

  /// [disableDatesAfterToday] is used to disable dates after today in date picker
  final bool disableDatesAfterToday;

  /// [datesHasEvent] is used to mark dates with events in date picker
  final List<DateTime> datesHasEvent;

  /// [initialSelectedDate] is used to set the initial selected date in date picker
  final DateTime? initialSelectedDate;

  /// [activeDates] is used to enable dates in date picker
  final List<DateTime>? activeDates;

  /// [inactiveDates] is used to disable dates in date picker
  final List<DateTime>? inactiveDates;

  /// [buttonStyle] is used to customize the style of the elevated button in date picker
  final ButtonStyle? buttonStyle;

  /// [labelButtonDatePicker] is used to customize the label of the elevated button in date picker
  final Text labelButtonDatePicker;

  /// [defaultDayTextStyle] is used for the date selected style from the date picker
  final TextStyle dateSelectedStyle;
  const DatePickerConfig({
    this.dayTextStyle = defaultDayTextStyle,
    this.dateTextStyle = defaultDateTextStyle,
    this.selectedTextColor = Colors.black,
    this.selectionColor = MyColors.defaultSelectionColor,
    this.deactivatedColor = MyColors.defaultDeactivatedColor,
    this.disableDatesAfterToday = true,
    this.datesHasEvent = const [],
    this.initialSelectedDate,
    this.activeDates,
    this.inactiveDates,
    this.buttonStyle,
    this.dateSelectedStyle = const TextStyle(
      color: MyColors.defaultDayColor,
      fontSize: 15,
    ),
    this.labelButtonDatePicker = const Text('Select Date',
        style: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
  });
}
