import 'package:arduino_garden/config/config.dart';
import 'package:arduino_garden/config/state_handler.dart';
import 'package:arduino_garden/models/schedule.dart';
import 'package:arduino_garden/popups/schedule_edit.dart';
import 'package:arduino_garden/widgets/grid_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListSchedules extends StatefulWidget {
  const ListSchedules({Key? key}) : super(key: key);

  @override
  State<ListSchedules> createState() => _ListSchedulesState();
}

class _ListSchedulesState extends State<ListSchedules> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Schedule> schedules = Provider.of<StateHandler>(context).schedules;

    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: GridCard(
        aspectRatio: 10 / 14,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(top: 18.0),
              child: Text(
                'Your Schedules',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
              ),
            ),
            Divider(
              color: Colors.pink,
              thickness: 1,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.00, bottom: 16),
                child: IntrinsicHeight(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 8.0, top: 8.0),
                            child: Text(
                              schedules[index].scheduleName,
                              style: TextStyle(
                                color: Color.fromARGB(255, 52, 37, 19),
                                fontWeight: FontWeight.w400,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              if (true) ...{
                                //TODO: MAKE IF SCHEDULE IS DELETABLE
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    onPressed: () {
                                      //TODO: DELETE
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: Colors.pink,
                                  ),
                                ),
                              },
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const ScheduleEdit();
                                        });
                                  },
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Colors.pink,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  onPressed: () async {
                                    await api.updateGardenSchedule(
                                      Provider.of<StateHandler>(context,
                                              listen: false)
                                          .token!,
                                      Provider.of<StateHandler>(context,
                                              listen: false)
                                          .currentGarden!
                                          .id,
                                      schedules[index].id,
                                    );
                                    await Provider.of<StateHandler>(context,
                                            listen: false)
                                        .updateAll();

                                    Navigator.of(context).pop(true);
                                    //TODO: make the button open "custom_schedule_setup" with current settings and on save replace this schedule with the new one
                                  },
                                  child: Text(
                                    'Select',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Colors.pink,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.pink,
                            thickness: 1,
                          ),
                        ],
                      );
                    },
                    itemCount: schedules.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
