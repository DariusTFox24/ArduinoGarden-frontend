import 'package:flutter/material.dart';

class NotificationsSettings extends StatefulWidget {
  const NotificationsSettings({Key? key}) : super(key: key);

  @override
  State<NotificationsSettings> createState() => _NotificationsSettingsState();
}

class _NotificationsSettingsState extends State<NotificationsSettings> {
  bool sendNotificationsAll = true;

  bool sendNotificationsDeviceConnection = true;
  bool whenDeviceGoesOnline = true;
  bool whenDeviceGoesOffline = true;

  bool sendNotificationsSensors = true;
  bool sendNotificationsTemp = true;
  RangeValues tempThresholds = RangeValues(0, 30); //C

  bool sendNotificationsHumidity = true;
  RangeValues humidityThresholds = RangeValues(50, 80); //%

  bool sendNotificationsLightInt = false;
  RangeValues lightThresholds = RangeValues(0, 100); //%

  bool sendNotificationsSolar = false;
  RangeValues solarThresholds = RangeValues(4, 6); //V

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Notifications Settings'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 18.0),
            child: Text(
              'General Notifications',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 22,
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 16.0, bottom: 16.0, left: 16.0, right: 8.0),
                child: Text(
                  "Notifications:",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                  ),
                ),
              ),
              Switch(
                value: sendNotificationsAll,
                onChanged: (value) {
                  setState(() {
                    sendNotificationsAll = value;
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.00, bottom: 16),
              child: IntrinsicHeight(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 18.0),
                        child: Text(
                          'Advanced Settings',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    if (sendNotificationsAll) ...{
                      Row(
                        //DEVICE CONNECTION ALERTS TOGGLE
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
                            child: Text(
                              "Device Connection Alerts:",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Switch(
                            value: sendNotificationsDeviceConnection,
                            onChanged: (value) {
                              setState(() {
                                sendNotificationsDeviceConnection = value;
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                      if (sendNotificationsDeviceConnection) ...{
                        Row(
                          //WHEN DEVICE GOES ONLINE
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 16.0,
                                  bottom: 16.0,
                                  left: 16.0,
                                  right: 8.0),
                              child: Text(
                                "When Device goes online:",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Switch(
                              value: whenDeviceGoesOnline,
                              onChanged: (value) {
                                setState(() {
                                  whenDeviceGoesOnline = value;
                                });
                              },
                              activeTrackColor: Colors.lightGreenAccent,
                              activeColor: Colors.green,
                            ),
                          ],
                        ),
                        Row(
                          //WHEN DEVICE GOES OFFLINE
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 16.0,
                                  bottom: 16.0,
                                  left: 16.0,
                                  right: 8.0),
                              child: Text(
                                "When Device goes offline:",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Switch(
                              value: whenDeviceGoesOffline,
                              onChanged: (value) {
                                setState(() {
                                  whenDeviceGoesOffline = value;
                                });
                              },
                              activeTrackColor: Colors.lightGreenAccent,
                              activeColor: Colors.green,
                            ),
                          ],
                        ),
                      },
                      Divider(
                        color: Colors.pink,
                      ),
                      Row(
                        //DEVICE CONNECTION ALERTS TOGGLE
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
                            child: Text(
                              "Sensor Alerts:",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Switch(
                            value: sendNotificationsSensors,
                            onChanged: (value) {
                              setState(() {
                                sendNotificationsSensors = value;
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                      if (sendNotificationsSensors) ...{
                        Row(
                          //TEMPERATUE ALERTS TOGGLE
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 16.0,
                                  bottom: 16.0,
                                  left: 8.0,
                                  right: 8.0),
                              child: Text(
                                "Temperature Alerts:",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Switch(
                              value: sendNotificationsTemp,
                              onChanged: (value) {
                                setState(() {
                                  sendNotificationsTemp = value;
                                });
                              },
                              activeTrackColor: Colors.lightGreenAccent,
                              activeColor: Colors.green,
                            ),
                          ],
                        ),
                        if (sendNotificationsTemp) ...{
                          //TEMPERATURE ALERTS RANGE

                          Padding(
                            padding: EdgeInsets.only(
                                top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
                            child: Text(
                              "When outside of range:",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          RangeSlider(
                            values: tempThresholds,
                            onChanged: (RangeValues newRange) {
                              setState(() => tempThresholds = newRange);
                            },
                            min: -25,
                            max: 75,
                            divisions: 20,
                            labels: RangeLabels(
                                '${tempThresholds.start.round()}°C',
                                '${tempThresholds.end.round()}°C'),
                          ),
                        },
                        Divider(
                          color: Colors.pink,
                        ),
                        Row(
                          //HUMIDITY ALERTS TOGGLE
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 16.0,
                                  bottom: 16.0,
                                  left: 8.0,
                                  right: 8.0),
                              child: Text(
                                "Humidity Alerts:",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Switch(
                              value: sendNotificationsHumidity,
                              onChanged: (value) {
                                setState(() {
                                  sendNotificationsHumidity = value;
                                });
                              },
                              activeTrackColor: Colors.lightGreenAccent,
                              activeColor: Colors.green,
                            ),
                          ],
                        ),
                        if (sendNotificationsHumidity) ...{
                          //HUMIDITY ALERTS RANGE

                          Padding(
                            padding: EdgeInsets.only(
                                top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
                            child: Text(
                              "When outside of range:",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          RangeSlider(
                            values: humidityThresholds,
                            onChanged: (RangeValues newRange) {
                              setState(() => humidityThresholds = newRange);
                            },
                            min: 0,
                            max: 100,
                            divisions: 20,
                            labels: RangeLabels(
                                '${humidityThresholds.start.round()}%',
                                '${humidityThresholds.end.round()}%'),
                          ),
                        },
                        Divider(
                          color: Colors.pink,
                        ),
                        Row(
                          //LIGHT ALERTS TOGGLE
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 16.0,
                                  bottom: 16.0,
                                  left: 8.0,
                                  right: 8.0),
                              child: Text(
                                "Light Intensity Alerts:",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Switch(
                              value: sendNotificationsLightInt,
                              onChanged: (value) {
                                setState(() {
                                  sendNotificationsLightInt = value;
                                });
                              },
                              activeTrackColor: Colors.lightGreenAccent,
                              activeColor: Colors.green,
                            ),
                          ],
                        ),
                        if (sendNotificationsLightInt) ...{
                          //LIGHT ALERTS RANGE

                          Padding(
                            padding: EdgeInsets.only(
                                top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
                            child: Text(
                              "When outside of range:",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          RangeSlider(
                            values: lightThresholds,
                            onChanged: (RangeValues newRange) {
                              setState(() => lightThresholds = newRange);
                            },
                            min: 0,
                            max: 100,
                            divisions: 20,
                            labels: RangeLabels(
                                '${lightThresholds.start.round()}%',
                                '${lightThresholds.end.round()}%'),
                          ),
                        },
                        Divider(
                          color: Colors.pink,
                        ),
                        Row(
                          //SOLAR ALERTS TOGGLE
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 16.0,
                                  bottom: 16.0,
                                  left: 8.0,
                                  right: 8.0),
                              child: Text(
                                "Solar Voltage Alerts:",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Switch(
                              value: sendNotificationsSolar,
                              onChanged: (value) {
                                setState(() {
                                  sendNotificationsSolar = value;
                                });
                              },
                              activeTrackColor: Colors.lightGreenAccent,
                              activeColor: Colors.green,
                            ),
                          ],
                        ),
                        if (sendNotificationsSolar) ...{
                          //SOLAR ALERTS RANGE

                          Padding(
                            padding: EdgeInsets.only(
                                top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
                            child: Text(
                              "When outside of range:",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          RangeSlider(
                            values: solarThresholds,
                            onChanged: (RangeValues newRange) {
                              setState(() => solarThresholds = newRange);
                            },
                            min: 0,
                            max: 10,
                            divisions: 20,
                            labels: RangeLabels('${solarThresholds.start}V',
                                '${solarThresholds.end}V'),
                          ),
                        },
                        Divider(
                          color: Colors.pink,
                        ),
                      },
                    } else ...{
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 18.0),
                          child: Text(
                            'Enable notifications to see advanced settings',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    },
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
