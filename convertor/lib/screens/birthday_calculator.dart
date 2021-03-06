import 'package:convertor/models/birthday.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthdayCalculator extends StatefulWidget {
  BirthdayCalculator({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BirthdayCalculatorState createState() => _BirthdayCalculatorState();
}

class _BirthdayCalculatorState extends State<BirthdayCalculator> {
  Birthday myBirthday;
  int monthsLived;
  int daysLived;
  int hoursLived;
  AllDateInfo numberOfYearsMonthsDaysLived = AllDateInfo(1, 1, 1);
  NextBirthday numberOfMonthsDaysBeforeNextBirthday = NextBirthday(1, 1);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2101));
    if (picked != null &&
        picked != DateTime.now() &&
        picked.isBefore(DateTime.now())) {
      setState(() {
        if (myBirthday == null) {
          myBirthday = Birthday(picked);
        } else {
          myBirthday.dateBirthday = picked;
        }
        Map<String, int> lifeDuration = myBirthday.lifeDuration();
        monthsLived = lifeDuration['month'];
        daysLived = lifeDuration['day'];
        hoursLived = lifeDuration['hour'];
        Map<String, int> allTimeLivingData = myBirthday.allTimeLiving();
        numberOfYearsMonthsDaysLived.years = allTimeLivingData['years'];
        numberOfYearsMonthsDaysLived.months = allTimeLivingData['months'];
        numberOfYearsMonthsDaysLived.days = allTimeLivingData['days'];
        Map<String, int> nextBirthdayData = myBirthday.nextBirthday();
        numberOfMonthsDaysBeforeNextBirthday.inDays =
            nextBirthdayData['months'];
        numberOfMonthsDaysBeforeNextBirthday.inMonths =
            nextBirthdayData['days'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Icon(
                    Icons.cake,
                    size: 150,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                        '${myBirthday != null ? DateFormat('yyyy-MM-dd').format(myBirthday.dateBirthday) : "Select my birthday"}'),
                  ),
                )
              ],
            ),
            Visibility(
                visible: myBirthday != null && myBirthday.dateBirthday != null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'You lived\ ${numberOfYearsMonthsDaysLived.years} year(s), \ ${numberOfYearsMonthsDaysLived.months} month and\ ${numberOfYearsMonthsDaysLived.days} day(s).'),
                    Text(
                        'Your next birthday is in \ ${numberOfMonthsDaysBeforeNextBirthday.inDays} month and\ ${numberOfMonthsDaysBeforeNextBirthday.inDays} day(s).'),
                    Text('Number of months lived: ' + '$monthsLived'),
                    Text('Number of days lived: ' + '$daysLived'),
                    Text('Number of hours lived: ' + '$hoursLived'),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
