import 'package:flutter/material.dart';

class ScheduleEdit extends StatefulWidget {
  const ScheduleEdit({Key? key}) : super(key: key);
  //TODO: MAKE PAGE GET INITIAL VALUES FROM THE SCHEDULE TO BE EDITED
  @override
  State<ScheduleEdit> createState() => _ScheduleEditState();
}

class _ScheduleEditState extends State<ScheduleEdit> {
  TimeOfDay timePump = TimeOfDay(hour: 8, minute: 30);
  TimeOfDay timeLights = TimeOfDay(hour: 8, minute: 30);
  final scheduleName = TextEditingController();
  final durationPump = TextEditingController();
  final durationLights = TextEditingController();

  final List<bool> _weekdaysPump = [
    true, //Mon
    false, //Tue
    false, //Wed
    false, //Thu
    false, //Fri
    false, //Sat
    false //Sun
  ];
  final List<bool> _weekdaysLight = [
    true, //Mon
    false, //Tue
    false, //Wed
    false, //Thu
    false, //Fri
    false, //Sat
    false //Sun
  ];

  @override
  Widget build(BuildContext context) {
    final hoursPump = timePump.hour.toString().padLeft(2, '0');
    final minutesPump = timePump.minute.toString().padLeft(2, '0');
    final hoursLights = timeLights.hour.toString().padLeft(2, '0');
    final minutesLights = timeLights.minute.toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Edit Schdeule'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 18.0),
            child: Text(
              'Edit Schedule Name',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 22,
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
            child: TextField(
              controller: scheduleName,
              decoration: const InputDecoration(
                hintText: 'Schedule Name',
                suffixIcon: Icon(Icons.edit),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.00, bottom: 16),
              child: IntrinsicHeight(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 18.0),
                      child: Text(
                        'Pump Schedule',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Row(
                      //SELECT ACTIVE DAYS ROW
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8, top: 18.0),
                          child: Text(
                            'Weekdays:',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //WEEKDAYS SELECT ROW
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(left: 6),
                        child: ToggleButtons(
                          children: [
                            Text(
                              "Mon",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Tue",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Wed",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Thu",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Fri",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Sat",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Sun",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                          onPressed: (int index) {
                            int count = 0;
                            _weekdaysPump.forEach((bool val) {
                              if (val) count++;
                            });

                            if (_weekdaysPump[index] && count <= 1) return;

                            setState(() {
                              _weekdaysPump[index] = !_weekdaysPump[index];
                            });
                          },
                          isSelected: _weekdaysPump,
                          constraints:
                              BoxConstraints(minWidth: 40.0, minHeight: 40.0),
                        ),
                      ),
                    ),
                    Row(
                      //SELECT Time ROW
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8, top: 8.0),
                          child: Text(
                            'Time of Day: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: OutlinedButton(
                            child: Text(
                              '$hoursPump:$minutesPump',
                              style: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                            onPressed: () async {
                              TimeOfDay? newTime = await showTimePicker(
                                context: context,
                                initialTime: timePump,
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.fromSwatch(
                                          backgroundColor:
                                              const Color(0xFFFFF8E1),
                                          primarySwatch: Colors.pink,
                                          cardColor: const Color(0xFFFFF8E1)),
                                      backgroundColor: const Color(0xFFFFF8E1),
                                      textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                              textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                              primary: Colors
                                                  .white, // color of button's letters
                                              backgroundColor: Colors
                                                  .pink, // Background color
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1,
                                                      style: BorderStyle.solid),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)))),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (newTime == null) return;

                              setState(() => timePump = newTime);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      //SELECT DURATION ROW
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8, top: 8.0),
                          child: Text(
                            'Duration:',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 6, right: 16),
                            child: TextField(
                              controller: durationPump,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Seconds',
                                suffixIcon: Icon(Icons.edit),
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///LIGHT SCHEDULE
                    Padding(
                      padding: EdgeInsets.only(top: 18.0),
                      child: Text(
                        'Grow Light Schedule',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Row(
                      //SELECT ACTIVE DAYS ROW
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8, top: 18.0),
                          child: Text(
                            'Weekdays:',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //WEEKDAYS SELECT ROW
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(left: 6),
                        child: ToggleButtons(
                          children: [
                            Text(
                              "Mon",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Tue",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Wed",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Thu",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Fri",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Sat",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Sun",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                          onPressed: (int index) {
                            int count = 0;
                            _weekdaysLight.forEach((bool val) {
                              if (val) count++;
                            });

                            if (_weekdaysLight[index] && count <= 1) return;

                            setState(() {
                              _weekdaysLight[index] = !_weekdaysLight[index];
                            });
                          },
                          isSelected: _weekdaysLight,
                          constraints:
                              BoxConstraints(minWidth: 40.0, minHeight: 40.0),
                        ),
                      ),
                    ),
                    Row(
                      //SELECT Time ROW
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8, top: 8.0),
                          child: Text(
                            'Time of Day: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: OutlinedButton(
                            child: Text(
                              '$hoursLights:$minutesLights',
                              style: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                            onPressed: () async {
                              TimeOfDay? newTime = await showTimePicker(
                                context: context,
                                initialTime: timeLights,
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.fromSwatch(
                                          backgroundColor:
                                              const Color(0xFFFFF8E1),
                                          primarySwatch: Colors.pink,
                                          cardColor: const Color(0xFFFFF8E1)),
                                      backgroundColor: const Color(0xFFFFF8E1),
                                      textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                              textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                              primary: Colors
                                                  .white, // color of button's letters
                                              backgroundColor: Colors
                                                  .pink, // Background color
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1,
                                                      style: BorderStyle.solid),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)))),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (newTime == null) return;

                              setState(() => timeLights = newTime);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      //SELECT DURATION ROW
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8, top: 8.0),
                          child: Text(
                            'Duration:',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 6, right: 16),
                            child: TextField(
                              controller: durationLights,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Minutes',
                                suffixIcon: Icon(Icons.edit),
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 8, right: 8, bottom: 16),
                child: MaterialButton(
                  padding: EdgeInsets.only(
                      bottom: 12.0, top: 12.0, left: 34, right: 34),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  color: Colors.pink,
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    //TODO: CREATE SCHEDULE
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
