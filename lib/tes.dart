import 'package:flutter/material.dart';

class MyDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Datepicker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyDatePage(),
    );
  }
}

class MyDatePage extends StatefulWidget {
  @override
  _MyDatePageState createState()
  {
    return _MyDatePageState();
  }
}

class _MyDatePageState extends State<MyDatePage> {
String date = "";
DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Datepicker"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () async{
                  DateTime? selected = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2010),
                  lastDate: DateTime(2025), 
                );
                if (selected != null && selected != selectedDate)
                  setState(() {
                    selectedDate = selected;
                  });
              },
              child: Text("Choose Date"),
            ),
            Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")
          ],
        ),
      ),
    );
  }

//   showDatePicker ({
//     @required var context = BuildContext,
//     @required var initialDate = DateTime,
//     @required var firstDate = DateTime,
//     @required var lastDate = DateTime,
//     var currentDate = DateTime,
//     DatePickerEntryMode initialEntryMode:
//     DatePickerEntryMode.calendar,
//     var selectableDayPredicate = SelectableDayPredicate,
//     var helpText = String,
//     var cancelText = String,
//     var confirmText = String,
//     var locale = Locale,
//     bool useRootNavigator: true,
//     var routeSettings = RouteSettings,
//     var textDirection = TextDirection,
//     var builder = TransitionBuilder,
//     DatePickerMode initialDatePickerMode: DatePickerMode.day,
//     var errorFormatText = String,
//     var errorInvalidText = String,
//     var fieldHintText = String,
//     var fieldLabelText = String
// }
// )
}

//   _selectDate(BuildContext context) async {
//     DateTime? selected = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2010),
//       lastDate: DateTime(2025), 
//     );
//     if (selected != null && selected != selectedDate)
//       setState(() {
//         selectedDate = selected;
//       });
//   }
// }