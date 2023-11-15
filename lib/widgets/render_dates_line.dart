import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tbib_monthly_date_picker/tbib_monthly_date_picker.dart';
import 'package:tbib_monthly_date_picker/widgets/render_dates.dart';

class DatePickerController {
  _DatePickerState? _datePickerState;

  /// This function will animate to any date that is passed as an argument
  /// In case a date is out of range nothing will happen
  void animateToDate(DateTime date,
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);
  }

  /// This function will animate the Timeline to the currently selected Date
  void animateToSelection(
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // animate to the current date
    _datePickerState!._controller.animateTo(
        _calculateDateOffset(
            _datePickerState!._currentDate!.add(const Duration(days: -3))),
        duration: duration,
        curve: curve);
  }

  void jumpToSelection() {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // jump to the current Date
    _datePickerState!._controller
        .jumpTo(_calculateDateOffset(_datePickerState!._currentDate!));
  }

  /// This function will animate to any date that is passed as an argument
  /// this will also set that date as the current selected date
  void setDateAndAnimate(DateTime date,
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);

    DateTime compareDate = DateTime(_datePickerState!.widget.currentMonthDate.y,
        _datePickerState!.widget.currentMonthDate.m, 0);

    if (date.compareTo(compareDate) >= 0 &&
        date.compareTo(
                compareDate.add(Duration(days: _datePickerState!.totalDays))) <=
            0) {
      // date is in the range
      _datePickerState!._currentDate = date;
    }
  }

  void setDatePickerState(_DatePickerState state) {
    _datePickerState = state;
  }

  /// Calculate the number of pixels that needs to be scrolled to go to the
  /// date provided in the argument
  double _calculateDateOffset(DateTime date) {
    final startDate = DateTime(_datePickerState!.widget.currentMonthDate.y,
        _datePickerState!.widget.currentMonthDate.m, 0);

    int offset = date.difference(startDate).inDays;
    return (offset * _datePickerState!.widget.width) + (offset * 6);
  }
}

class DatePickerTimeLine extends StatefulWidget {
  /// m for int month , y for year
  final ({int m, int y}) currentMonthDate;

  final DateTime? animateToDate;

  /// Contains the list of dates that have events
  final List<DateTime> datesHasEvent;

  /// disable any dates after today
  final bool disableDatesAfterToday;

  /// Width of the selector
  final double width;

  /// Height of the selector
  final double height;

  /// DatePicker Controller
  final DatePickerController? controller;

  /// Text color for the selected Date
  final Color selectedTextColor;

  /// Background color for the selector
  final Color selectionColor;

  /// Text Color for the deactivated dates
  final Color deactivatedColor;

  // /// TextStyle for Month Value
  // final TextStyle monthTextStyle;

  /// TextStyle for day Value
  final TextStyle dayTextStyle;

  /// TextStyle for the date Value
  final TextStyle dateTextStyle;

  /// Current Selected Date
  final DateTime? /*?*/ initialSelectedDate;

  /// Contains the list of inactive dates.
  /// All the dates defined in this List will be deactivated
  final List<DateTime>? inactiveDates;

  /// Contains the list of active dates.
  /// Only the dates in this list will be activated.
  final List<DateTime>? activeDates;

  /// Callback function for when a different date is selected
  final DateChangeListener? onDateChange;

  /// Locale for the calendar default: en_us
  final String locale;

  const DatePickerTimeLine({
    required this.currentMonthDate,
    super.key,
    this.width = 60,
    this.height = 80,
    this.controller,
    // this.monthTextStyle = defaultMonthTextStyle,
    this.dayTextStyle = defaultDayTextStyle,
    this.dateTextStyle = defaultDateTextStyle,
    this.selectedTextColor = Colors.white,
    this.selectionColor = MyColors.defaultSelectionColor,
    this.deactivatedColor = MyColors.defaultDeactivatedColor,
    this.initialSelectedDate,
    this.activeDates,
    this.inactiveDates,
    this.onDateChange,
    this.disableDatesAfterToday = true,
    this.datesHasEvent = const [],
    this.animateToDate,
    this.locale = "en_US",
  }) : assert(
            activeDates == null || inactiveDates == null,
            "Can't "
            "provide both activated and deactivated dates List at the same time.");

  @override
  State<StatefulWidget> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePickerTimeLine> {
  DateTime? _currentDate;
  var totalDays = 31;
  bool firstOpen = true;
  final ScrollController _controller = ScrollController();

  late final TextStyle selectedDateStyle;
  late final TextStyle selectedMonthStyle;
  late final TextStyle selectedDayStyle;

  late final TextStyle deactivatedDateStyle;
  late final TextStyle deactivatedMonthStyle;
  late final TextStyle deactivatedDayStyle;
  @override
  Widget build(BuildContext context) {
    totalDays = DateTimeRange(
            start: DateTime(
                widget.currentMonthDate.y, widget.currentMonthDate.m, 0),
            end: DateTime(
                widget.currentMonthDate.y, widget.currentMonthDate.m + 1, 0))
        .duration
        .inDays;
    if (firstOpen) {
      _currentDate = widget.initialSelectedDate;
    } else {
      _currentDate = widget.animateToDate ?? _currentDate;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (widget.animateToDate != null &&
      //     widget.animateToDate!.month == widget.currentMonthDate.m &&
      //     widget.animateToDate!.year == widget.currentMonthDate.y) {
      widget.controller?.setDatePickerState(this);

      widget.controller?.animateToSelection();
      //  }
    });
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        itemCount: totalDays,
        scrollDirection: Axis.horizontal,
        controller: _controller,
        itemBuilder: (context, index) {
          DateTime endDate =
              DateTime(widget.currentMonthDate.y, widget.currentMonthDate.m, 1);
          // get the date object based on the index position
          // if widget.startDate is null then use the initialDateValue
          DateTime date;
          DateTime date0 = endDate.add(Duration(days: index));
          date = DateTime(date0.year, date0.month, date0.day);

          bool isDeactivated = false;
          if (widget.disableDatesAfterToday) {
            if (date.year == DateTime.now().year &&
                date.month == DateTime.now().month) {
              if (date.day > DateTime.now().day) {
                isDeactivated = true;
              }
            }
          }

          // check if this date needs to be deactivated for only DeactivatedDates
          if (widget.inactiveDates != null) {
            for (DateTime inactiveDate in widget.inactiveDates!) {
              if (DateUtils.isSameDay(date, inactiveDate)) {
                isDeactivated = true;
                break;
              }
            }
          }

          // check if this date needs to be deactivated for only ActivatedDates
          if (widget.activeDates != null) {
            isDeactivated = true;
            for (DateTime activateDate in widget.activeDates!) {
              if (DateUtils.isSameDay(date, activateDate)) {
                isDeactivated = false;
                break;
              }
            }
          }
          // Check if this date is the one that is currently selected
          bool isSelected = _currentDate != null
              ? DateUtils.isSameDay(date, _currentDate!)
              : false;

          // Return the Date Widget
          return DateWidget(
            date: date,
            datesHasEvent: widget.datesHasEvent,
            // monthTextStyle: isDeactivated
            //     ? deactivatedMonthStyle
            //     : isSelected
            //         ? selectedMonthStyle
            //         : widget.monthTextStyle,
            dateTextStyle: isDeactivated
                ? deactivatedDateStyle
                : isSelected
                    ? selectedDateStyle
                    : widget.dateTextStyle,
            dayTextStyle: isDeactivated
                ? deactivatedDayStyle
                : isSelected
                    ? selectedDayStyle
                    : widget.dayTextStyle,
            width: widget.width,
            locale: widget.locale,
            selectionColor:
                isSelected ? widget.selectionColor : Colors.transparent,
            onDateSelected: (selectedDate) {
              // Don't notify listener if date is deactivated
              if (isDeactivated) return;

              // A date is selected
              widget.onDateChange?.call(selectedDate);

              setState(() {
                _currentDate = selectedDate;
              });
            },
          );
        },
      ),
    );
  }

  @override
  void initState() {
    // Init the calendar locale
    initializeDateFormatting(widget.locale, null);
    // Set initial Values
    _currentDate = widget.initialSelectedDate;

    widget.controller?.setDatePickerState(this);

    selectedDateStyle =
        widget.dateTextStyle.copyWith(color: widget.selectedTextColor);
    // selectedMonthStyle =
    //     widget.monthTextStyle.copyWith(color: widget.selectedTextColor);
    selectedDayStyle =
        widget.dayTextStyle.copyWith(color: widget.selectedTextColor);

    deactivatedDateStyle =
        widget.dateTextStyle.copyWith(color: widget.deactivatedColor);
    // deactivatedMonthStyle =
    //     widget.monthTextStyle.copyWith(color: widget.deactivatedColor);
    deactivatedDayStyle =
        widget.dayTextStyle.copyWith(color: widget.deactivatedColor);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      firstOpen = false;
    });
    super.initState();
  }
}
