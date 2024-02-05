# TBIB_MONTHLY_DATE_PICKER

This package for Date picker monthly and change month and then select day

<img  src="https://github.com/the-best-is-best/tbib_monthly_date_picker/blob/main/github_assets/Screenshot1.png?raw=true" height="300"></img>

<img  src="https://github.com/the-best-is-best/tbib_monthly_date_picker/blob/main/github_assets/Screenshot2.png?raw=true" height="300"></img>

- How to use

```dart
lass MainApp extends StatelessWidget {
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

```

