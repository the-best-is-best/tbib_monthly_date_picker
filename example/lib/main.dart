import 'package:flutter/material.dart';
import 'package:tbib_monthly_date_picker/extra/date_picker_config.dart';
import 'package:tbib_monthly_date_picker/widgets/render_dates_line.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: SizedBox(
              child: DatePickerTimeLine(
            controller: DatePickerController(),
            datePickerConfig: const DatePickerConfig(
                dateTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                dayTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                dateSelectedStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
                selectionColor: Colors.cyan,
                selectedTextColor: Colors.white),
          )),
        ),
      ),
    );
  }
}
