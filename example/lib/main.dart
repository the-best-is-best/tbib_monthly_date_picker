import 'package:flutter/material.dart';
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
        body: Center(
          child: SizedBox(
              child: DatePickerTimeLine(
            controller: DatePickerController(),
          )),
        ),
      ),
    );
  }
}
