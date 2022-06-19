import 'package:arduino_garden/config/config.dart';
import 'package:arduino_garden/config/state_handler.dart';
import 'package:arduino_garden/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = this.minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}

class ScheduleSetup extends StatefulWidget {
  const ScheduleSetup({Key? key}) : super(key: key);

  @override
  State<ScheduleSetup> createState() => _ScheduleSetupState();
}

class _ScheduleSetupState extends State<ScheduleSetup> {
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
        title: Text('Create New Schdeule'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 18.0),
            child: Text(
              'New Schedule Name',
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
              decoration: const InputDecoration(hintText: 'Schedule Name'),
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
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Divider(
                        color: Colors.pink,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Pump Schedule',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Row(
                      //SELECT ACTIVE DAYS ROW
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8, top: 4.0),
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
                              decoration:
                                  const InputDecoration(hintText: 'Seconds'),
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
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Divider(
                        color: Colors.pink,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Grow Light Schedule',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ),

                    Row(
                      //SELECT ACTIVE DAYS ROW
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8, top: 4.0),
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
                              decoration:
                                  const InputDecoration(hintText: 'Minutes'),
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
                    'Create',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () async {
                    Schedule schedule = await api.createSchedule(
                        Provider.of<StateHandler>(context, listen: false)
                            .token!,
                        {
                          "weekdaysPump": {
                            "monday": _weekdaysPump[0],
                            "tuesday": _weekdaysPump[1],
                            "wednesday": _weekdaysPump[2],
                            "thursday": _weekdaysPump[3],
                            "friday": _weekdaysPump[4],
                            "saturday": _weekdaysPump[5],
                            "sunday": _weekdaysPump[6]
                          },
                          "weekdaysLight": {
                            "monday": _weekdaysLight[0],
                            "tuesday": _weekdaysLight[1],
                            "wednesday": _weekdaysLight[2],
                            "thursday": _weekdaysLight[3],
                            "friday": _weekdaysLight[4],
                            "saturday": _weekdaysLight[5],
                            "sunday": _weekdaysLight[6]
                          },
                          "durationPump": durationPump.text,
                          "durationLights": durationLights.text,
                          "scheduleName": scheduleName.text,
                          "timePump": timePump.to24hours(),
                          "timeLights": timeLights.to24hours(),
                        });
                    await Provider.of<StateHandler>(context, listen: false)
                        .updateSchedules();
                    await Provider.of<StateHandler>(context, listen: false)
                        .updateUser();

                    Navigator.of(context).pop();
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
