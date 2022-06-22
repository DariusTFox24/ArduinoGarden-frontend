import 'package:arduino_garden/config/state_handler.dart';
import 'package:arduino_garden/models/garden.dart';
import 'package:arduino_garden/popups/schedule_setup.dart';
import 'package:arduino_garden/popups/list_schedules.dart';
import 'package:arduino_garden/widgets/grid_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  Garden? currentGarden;
  TimeOfDay timePump = TimeOfDay(hour: 8, minute: 30);
  TimeOfDay timeLights = TimeOfDay(hour: 18, minute: 30);
  String scheduleName = "Test Schedule";
  int durationPump = 80; //seconds
  int durationLights = 360; //minutes
  bool isScheduleActive = true;

  List<bool> _weekdaysPump = [
    true, //Mon
    false, //Tue
    false, //Wed
    false, //Thu
    true, //Fri
    false, //Sat
    false //Sun
  ];
  List<bool> _weekdaysLight = [
    false, //Mon
    false, //Tue
    false, //Wed
    false, //Thu
    false, //Fri
    true, //Sat
    true //Sun
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentGarden = Provider.of<StateHandler>(context).currentGarden;
    if (currentGarden!.schedule != null) {
      scheduleName = currentGarden!.schedule!.scheduleName;
      durationLights = int.parse(currentGarden!.schedule!.durationLights);
      durationPump = int.parse(currentGarden!.schedule!.durationPump) - 3;
      _weekdaysPump = [
        currentGarden!.schedule!.weekdaysPump.monday,
        currentGarden!.schedule!.weekdaysPump.tuesday,
        currentGarden!.schedule!.weekdaysPump.wednesday,
        currentGarden!.schedule!.weekdaysPump.thursday,
        currentGarden!.schedule!.weekdaysPump.friday,
        currentGarden!.schedule!.weekdaysPump.saturday,
        currentGarden!.schedule!.weekdaysPump.sunday,
      ];
      _weekdaysLight = [
        currentGarden!.schedule!.weekdaysLight.monday,
        currentGarden!.schedule!.weekdaysLight.tuesday,
        currentGarden!.schedule!.weekdaysLight.wednesday,
        currentGarden!.schedule!.weekdaysLight.thursday,
        currentGarden!.schedule!.weekdaysLight.friday,
        currentGarden!.schedule!.weekdaysLight.saturday,
        currentGarden!.schedule!.weekdaysLight.sunday,
      ];
      timePump = TimeOfDay(
        hour: int.parse(currentGarden!.schedule!.timePump.split(":")[0]),
        minute: int.parse(
          currentGarden!.schedule!.timePump.split(":")[1],
        ),
      );
      timeLights = TimeOfDay(
        hour: int.parse(currentGarden!.schedule!.timeLights.split(":")[0]),
        minute: int.parse(
          currentGarden!.schedule!.timeLights.split(":")[1],
        ),
      );
    }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.pink.shade600,
              Colors.amber.shade900,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Schedules",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                ),
              ),
            ),
            Divider(
              color: Colors.pinkAccent,
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: MaterialButton(
                onPressed: () async {
                  final thing = await showDialog(
                      context: context,
                      builder: (context) {
                        return const ListSchedules();
                      });
                  if (thing != null && thing as bool) {
                    Provider.of<StateHandler>(context, listen: false)
                        .updateAll();
                    setState(() {});
                  }
                },
                color: Colors.pink,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.calendarCheck,
                                color: Colors.yellow,
                                size: 26,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Select Schedule',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: MaterialButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const ScheduleSetup();
                      });
                },
                color: Colors.pink,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.calendarPlus,
                                color: Colors.yellow,
                                size: 26,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Create New Schedule',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (currentGarden!.schedule != null) ...[
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: GridCard(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      if (!isScheduleActive) ...{
                        Icon(
                          FontAwesomeIcons.powerOff,
                          size: 186,
                          color: Colors.pink,
                        ),
                      },
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 16),
                            child: Center(
                              child: Text(
                                scheduleName,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 16),
                            child: Text(
                              "Pump Schedule:",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //WEEKDAYS
                            children: [
                              //Monday
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(
                                      color: _weekdaysPump[0]
                                          ? Colors.pink
                                          : Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Text(
                                        "Mon",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _weekdaysPump[0]
                                              ? Colors.pink
                                              : Colors.black,
                                        ),
                                      ),
                                      if (_weekdaysPump[0]) ...{
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 32,
                                            left: 24,
                                          ),
                                          child: Icon(
                                            Icons.water_drop,
                                            color: Colors.blue,
                                            size: 16,
                                          ),
                                        ),
                                      },
                                    ],
                                  ),
                                ),
                              ),

                              //Tuesday
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(
                                      color: _weekdaysPump[1]
                                          ? Colors.pink
                                          : Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Text(
                                        "Tue",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _weekdaysPump[1]
                                              ? Colors.pink
                                              : Colors.black,
                                        ),
                                      ),
                                      if (_weekdaysPump[1]) ...{
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 32,
                                            left: 24,
                                          ),
                                          child: Icon(
                                            Icons.water_drop,
                                            color: Colors.blue,
                                            size: 16,
                                          ),
                                        ),
                                      },
                                    ],
                                  ),
                                ),
                              ),

                              //Wednesday
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(
                                      color: _weekdaysPump[2]
                                          ? Colors.pink
                                          : Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Text(
                                        "Wed",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _weekdaysPump[2]
                                              ? Colors.pink
                                              : Colors.black,
                                        ),
                                      ),
                                      if (_weekdaysPump[2]) ...{
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 32,
                                            left: 24,
                                          ),
                                          child: Icon(
                                            Icons.water_drop,
                                            color: Colors.blue,
                                            size: 16,
                                          ),
                                        ),
                                      },
                                    ],
                                  ),
                                ),
                              ),

                              //Thursday
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(
                                      color: _weekdaysPump[3]
                                          ? Colors.pink
                                          : Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Text(
                                        "Thu",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _weekdaysPump[3]
                                              ? Colors.pink
                                              : Colors.black,
                                        ),
                                      ),
                                      if (_weekdaysPump[3]) ...{
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 32,
                                            left: 24,
                                          ),
                                          child: Icon(
                                            Icons.water_drop,
                                            color: Colors.blue,
                                            size: 16,
                                          ),
                                        ),
                                      },
                                    ],
                                  ),
                                ),
                              ),

                              //Friday
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(
                                      color: _weekdaysPump[4]
                                          ? Colors.pink
                                          : Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Text(
                                        "Fri",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _weekdaysPump[4]
                                              ? Colors.pink
                                              : Colors.black,
                                        ),
                                      ),
                                      if (_weekdaysPump[4]) ...{
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 32,
                                            left: 24,
                                          ),
                                          child: Icon(
                                            Icons.water_drop,
                                            color: Colors.blue,
                                            size: 16,
                                          ),
                                        ),
                                      },
                                    ],
                                  ),
                                ),
                              ),

                              //Saturday
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(
                                      color: _weekdaysPump[5]
                                          ? Colors.pink
                                          : Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Text(
                                        "Sat",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _weekdaysPump[5]
                                              ? Colors.pink
                                              : Colors.black,
                                        ),
                                      ),
                                      if (_weekdaysPump[5]) ...{
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 32,
                                            left: 24,
                                          ),
                                          child: Icon(
                                            Icons.water_drop,
                                            color: Colors.blue,
                                            size: 16,
                                          ),
                                        ),
                                      },
                                    ],
                                  ),
                                ),
                              ),

                              //Sunday
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, top: 8, right: 8),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(
                                      color: _weekdaysPump[6]
                                          ? Colors.pink
                                          : Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Text(
                                        "Sun",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _weekdaysPump[6]
                                              ? Colors.pink
                                              : Colors.black,
                                        ),
                                      ),
                                      if (_weekdaysPump[6]) ...{
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 32,
                                            left: 24,
                                          ),
                                          child: Icon(
                                            Icons.water_drop,
                                            color: Colors.blue,
                                            size: 16,
                                          ),
                                        ),
                                      },
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  "at ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  "${timePump.hour}:${timePump.minute}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.pink,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  "for ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  (durationPump >= (60 * 60))
                                      ? "${(durationPump / 60 / 60).toStringAsFixed(2)}"
                                      : (durationPump >= 60)
                                          ? "${(durationPump / 60).toStringAsFixed(2)}"
                                          : "$durationPump",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.pink,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  (durationPump >= (60 * 60))
                                      ? " hours."
                                      : (durationPump >= 60)
                                          ? " minutes."
                                          : " seconds.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Divider(color: Colors.pink, thickness: 0.5),
                          ),

                          ///LIGHT SCHEDULE
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 16),
                            child: Text(
                              "Grow Lights Schedule:",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //WEEKDAYS
                            children: [
                              //Monday
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(
                                      color: _weekdaysLight[0]
                                          ? Colors.pink
                                          : Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Text(
                                        "Mon",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _weekdaysLight[0]
                                              ? Colors.pink
                                              : Colors.black,
                                        ),
                                      ),
                                      if (_weekdaysLight[0]) ...{
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 32,
                                            left: 24,
                                          ),
                                          child: Icon(
                                            Icons.sunny,
                                            color: Colors.yellow,
                                            size: 16,
                                          ),
                                        ),
                                      },
                                    ],
                                  ),
                                ),
                              ),

                              //Tuesday
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(
                                      color: _weekdaysLight[1]
                                          ? Colors.pink
                                          : Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Text(
                                        "Tue",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _weekdaysLight[1]
                                              ? Colors.pink
                                              : Colors.black,
                                        ),
                                      ),
                                      if (_weekdaysLight[1]) ...{
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 32,
                                            left: 24,
                                          ),
                                          child: Icon(
                                            Icons.sunny,
                                            color: Colors.yellow,
                                            size: 16,
                                          ),
                                        ),
                                      },
                                    ],
                                  ),
                                ),
                              ),

                              //Wednesday
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(
                                      color: _weekdaysLight[2]
                                          ? Colors.pink
                                          : Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Text(
                                        "Wed",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _weekdaysLight[2]
                                              ? Colors.pink
                                              : Colors.black,
                                        ),
                                      ),
                                      if (_weekdaysLight[2]) ...{
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 32,
                                            left: 24,
                                          ),
                                          child: Icon(
                                            Icons.sunny,
                                            color: Colors.yellow,
                                            size: 16,
                                          ),
                                        ),
                                      },
                                    ],
                                  ),
                                ),
                              ),

                              //Thursday
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(
                                      color: _weekdaysLight[3]
                                          ? Colors.pink
                                          : Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Text(
                                        "Thu",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _weekdaysLight[3]
                                              ? Colors.pink
                                              : Colors.black,
                                        ),
                                      ),
                                      if (_weekdaysLight[3]) ...{
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 32,
                                            left: 24,
                                          ),
                                          child: Icon(
                                            Icons.sunny,
                                            color: Colors.yellow,
                                            size: 16,
                                          ),
                                        ),
                                      },
                                    ],
                                  ),
                                ),
                              ),

                              //Friday
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(
                                      color: _weekdaysLight[4]
                                          ? Colors.pink
                                          : Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Text(
                                        "Fri",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _weekdaysLight[4]
                                              ? Colors.pink
                                              : Colors.black,
                                        ),
                                      ),
                                      if (_weekdaysLight[4]) ...{
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 32,
                                            left: 24,
                                          ),
                                          child: Icon(
                                            Icons.sunny,
                                            color: Colors.yellow,
                                            size: 16,
                                          ),
                                        ),
                                      },
                                    ],
                                  ),
                                ),
                              ),

                              //Saturday
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(
                                      color: _weekdaysLight[5]
                                          ? Colors.pink
                                          : Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Text(
                                        "Sat",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _weekdaysLight[5]
                                              ? Colors.pink
                                              : Colors.black,
                                        ),
                                      ),
                                      if (_weekdaysLight[5]) ...{
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 32,
                                            left: 24,
                                          ),
                                          child: Icon(
                                            Icons.sunny,
                                            color: Colors.yellow,
                                            size: 16,
                                          ),
                                        ),
                                      },
                                    ],
                                  ),
                                ),
                              ),

                              //Sunday
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, top: 8, right: 8),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(
                                      color: _weekdaysLight[6]
                                          ? Colors.pink
                                          : Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Text(
                                        "Sun",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _weekdaysLight[6]
                                              ? Colors.pink
                                              : Colors.black,
                                        ),
                                      ),
                                      if (_weekdaysLight[6]) ...{
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 32,
                                            left: 24,
                                          ),
                                          child: Icon(
                                            Icons.sunny,
                                            color: Colors.yellow,
                                            size: 16,
                                          ),
                                        ),
                                      },
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  "at ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  "${timeLights.hour}:${timeLights.minute}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.pink,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  "for ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  (durationLights >= (60 * 24))
                                      ? "${(durationLights / 60 / 60).toStringAsFixed(2)}"
                                      : (durationLights >= 60)
                                          ? "${(durationLights / 60).toStringAsFixed(2)}"
                                          : "$durationLights",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.pink,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  (durationLights >= (60 * 24))
                                      ? " days."
                                      : (durationLights >= 60)
                                          ? " hours."
                                          : " minutes.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Divider(color: Colors.pink, thickness: 0.5),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 16.0,
                                    bottom: 16.0,
                                    left: 16.0,
                                    right: 8.0),
                                child: Text(
                                  "Active:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              Switch(
                                value: isScheduleActive,
                                onChanged: (value) {
                                  setState(() {
                                    isScheduleActive = value;
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
