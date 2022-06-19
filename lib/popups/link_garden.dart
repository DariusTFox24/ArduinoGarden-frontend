// ignore_for_file: dead_code

import 'dart:async';
import 'dart:convert';
import 'package:arduino_garden/config/config.dart';
import 'package:arduino_garden/models/garden.dart';
import 'package:arduino_garden/widgets/grid_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:app_settings/app_settings.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LinkGarden extends StatefulWidget {
  final Garden garden;
  const LinkGarden({Key? key, required this.garden}) : super(key: key);

  @override
  State<LinkGarden> createState() => _LinkGardenState();
}

class _LinkGardenState extends State<LinkGarden> {
  var step = 0;
  BluetoothDevice? arduinoDevice;

  String ssid = "";
  String pass = "";

  @override
  Widget build(BuildContext context) {
    final url = host.toString();
    final token = widget.garden.gardenToken;

    return AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: GridCard(
        aspectRatio: 3.0 / 3.5,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 18.0),
              child: Text(
                'Device Setup',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
              ),
            ),
            if (step == 0) ...[
              //CHECK IF BLUETOOTH IS ENABLED
              BluetoothCheckStep(
                onBluetoothEnabled: () {
                  setState(() {
                    step = 1;
                  });
                },
              )
            ] else if (step == 1) ...[
              //INFORM USER TO TURN ON ARDUINO DEVICE
              BeforeDeviceConnection(
                onStepComplete: () {
                  setState(() {
                    step = 2;
                  });
                },
              )
            ] else if (step == 2)
              //CONNECT TO ARDUINO DEVICE
              ...[
              DeviceConnectionStep(
                currentDevice: arduinoDevice,
                onDeviceConnected: (device) {
                  if (!mounted) return;
                  setState(() {
                    this.arduinoDevice = device;
                    step = 3;
                  });
                },
                onSearchFailed: () {
                  if (!mounted) return;
                  setState(() {
                    step = 4;
                  });
                },
              )
            ] else if (step == 4)
              //FAILED CONNECTION TO ARDUINO DEVICE... RETRY?
              ...[
              FailedDeviceConnectionStep(
                onRetryConnection: () {
                  setState(() {
                    step = 2;
                  });
                },
              )
            ] else if (step == 3) ...[
              //SUCCESSFUL CONNECTION TO DEVICE PROCEED
              ConnectedToDeviceStep(
                onStepComplete: () {
                  setState(() {
                    step = 5;
                  });
                },
              ),
            ] else if (step == 5) ...[
              //GET USERS INPUT ON WIFI NAME AND PASSWORD
              WiFiDetailsStep(
                onStepComplete: (ssid, pass) {
                  setState(() {
                    this.ssid = ssid;
                    this.pass = pass;
                    step = 6;
                  });
                },
              ),
            ] else if (step == 6)
              //CONNECTED TO DEVICE AND SETTING UP
              ...[
              SendingDataStep(
                device: arduinoDevice,
                gardenToken: token,
                url: url,
                password: this.pass,
                ssid: this.ssid,
                onSentComplete: () {
                  setState(() {
                    this.arduinoDevice = null;
                    step = 7;
                  });
                },
              )
            ] else if (step == 7)
              //ALL SET UP
              ...[
              SetupCompleteStep(
                onSetupDone: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
              )
            ],
          ],
        ),
      ),
    );
  }
}

class WiFiDetailsStep extends StatefulWidget {
  final void Function(String ssid, String pass) onStepComplete;
  const WiFiDetailsStep({Key? key, required this.onStepComplete})
      : super(key: key);

  @override
  State<WiFiDetailsStep> createState() => _WiFiDetailsStepState();
}

class _WiFiDetailsStepState extends State<WiFiDetailsStep> {
  final ssid = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(top: 18.0),
          child: Text(
            'Network Connection',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          padding:
              EdgeInsets.only(top: 30.0, bottom: 8.0, left: 8.0, right: 8.0),
          child: TextField(
            controller: ssid,
            decoration: const InputDecoration(hintText: 'WiFi Name'),
          ),
        ),
        Container(
          padding:
              EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
          child: TextField(
            controller: pass,
            decoration: const InputDecoration(hintText: 'WiFi Password'),
          ),
        ),
        MaterialButton(
          padding:
              EdgeInsets.only(bottom: 12.0, top: 12.0, left: 34, right: 34),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          color: Colors.pink,
          child: const Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          onPressed: () => widget.onStepComplete(ssid.text, pass.text),
        ),
      ],
    );
  }
}

class ConnectedToDeviceStep extends StatefulWidget {
  final void Function() onStepComplete;
  const ConnectedToDeviceStep({Key? key, required this.onStepComplete})
      : super(key: key);

  @override
  State<ConnectedToDeviceStep> createState() => _ConnectedToDeviceStepState();
}

class _ConnectedToDeviceStepState extends State<ConnectedToDeviceStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(top: 38, bottom: 12, left: 16, right: 16),
          child: Text(
            'Connected to your ArduinoGarden device!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 18.0),
          child: Text(
            'Press "Connect" to link your device',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 8,
            ),
          ),
        ),
        MaterialButton(
          padding:
              EdgeInsets.only(bottom: 12.0, top: 12.0, left: 34, right: 34),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          color: Colors.pink,
          child: const Text(
            'Connect',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          onPressed: () => widget.onStepComplete(),
        ),
      ],
    );
  }
}

class BeforeDeviceConnection extends StatefulWidget {
  final void Function() onStepComplete;
  const BeforeDeviceConnection({Key? key, required this.onStepComplete})
      : super(key: key);

  @override
  State<BeforeDeviceConnection> createState() => _BeforeDeviceConnectionState();
}

class _BeforeDeviceConnectionState extends State<BeforeDeviceConnection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: 38, bottom: 12, left: 16, right: 16),
          child: Text(
            'Make sure ArduinoDevice is powered on and in Setup Mode!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 18.0),
          child: Text(
            'Press "Start" to start the setup process',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 8,
            ),
          ),
        ),
        MaterialButton(
          padding:
              EdgeInsets.only(bottom: 12.0, top: 12.0, left: 34, right: 34),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          color: Colors.pink,
          child: const Text(
            'Start',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          onPressed: () => widget.onStepComplete(),
        ),
      ],
    );
  }
}

class DeviceConnectionStep extends StatefulWidget {
  final BluetoothDevice? currentDevice;
  final void Function() onSearchFailed;
  final void Function(BluetoothDevice) onDeviceConnected;
  const DeviceConnectionStep(
      {Key? key,
      required this.onSearchFailed,
      required this.onDeviceConnected,
      required this.currentDevice})
      : super(key: key);

  @override
  State<DeviceConnectionStep> createState() => _DeviceConnectionStepState();
}

class _DeviceConnectionStepState extends State<DeviceConnectionStep> {
  Future<void> configureBluetooth() async {
    bool success = false;
    bool searchedPrev = false;
    FlutterBlue.instance.stopScan();

    List<BluetoothDevice> connectedDevices =
        await FlutterBlue.instance.connectedDevices.whenComplete(() {
      searchedPrev = true;
    });

    if (searchedPrev) {
      for (BluetoothDevice bd in connectedDevices) {
        print(connectedDevices);
        if (bd.name == "ArduinoGarden") {
          bd.disconnect();
          if (kDebugMode) {
            Fluttertoast.showToast(
              msg: "Disconnected",
              toastLength: Toast.LENGTH_SHORT,
            );
          }
        }
      }
    }

    if (kDebugMode) {
      Fluttertoast.showToast(
        msg: "Searching",
        toastLength: Toast.LENGTH_SHORT,
      );
    }

    FlutterBlue.instance.stopScan();
    FlutterBlue.instance.scan(timeout: Duration(seconds: 30)).listen(
      (result) async {
        if (result.device.name == "ArduinoGarden") {
          await result.device
              .connect(autoConnect: false)
              .catchError((error) async {
            await result.device.disconnect();
            widget.onSearchFailed();
          });

          success = true;

          // Stop scanning
          FlutterBlue.instance.stopScan();

          if (kDebugMode) {
            Fluttertoast.showToast(
              msg: "Connected to " + result.device.name,
              toastLength: Toast.LENGTH_SHORT,
            );
          }

          widget.onDeviceConnected(result.device);
        }
      },
      cancelOnError: true,
      onError: (_) => widget.onSearchFailed(),
      onDone: () => success ? null : widget.onSearchFailed(),
    );
  }

  @override
  void initState() {
    configureBluetooth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(top: 38.0),
          child: Text(
            'Scanning for your ArduinoDevice...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 38.0),
          child: LoadingAnimationWidget.halfTriangleDot(
            color: Colors.pink,
            size: 124,
          ),
        ),
      ],
    );
  }
}

class FailedDeviceConnectionStep extends StatelessWidget {
  final void Function() onRetryConnection;
  const FailedDeviceConnectionStep({Key? key, required this.onRetryConnection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 22.0),
          child: Icon(
            Icons.signal_wifi_statusbar_connected_no_internet_4,
            color: Colors.red,
            size: 36,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            'Device not found!',
            style: TextStyle(
              color: Colors.red.shade400,
              fontWeight: FontWeight.w400,
              fontSize: 24,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 24, bottom: 12, left: 16, right: 16),
          child: Text(
            'Make sure the ArduinoDevice is on and in Setup Mode!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 18.0),
          child: Text(
            'Press "Try Again" to restart the setup process',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 8,
            ),
          ),
        ),
        MaterialButton(
          padding:
              EdgeInsets.only(bottom: 12.0, top: 12.0, left: 34, right: 34),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          color: Colors.pink,
          child: const Text(
            'Try Again',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          onPressed: () => onRetryConnection(),
        ),
      ],
    );
  }
}

class SendingDataStep extends StatefulWidget {
  final BluetoothDevice? device;
  final String ssid;
  final String password;
  final String gardenToken;
  final String url;

  static const String serviceUID = "7cbc7266-243e-4861-beb3-7c47ee8da7d9";
  static const String characteristicSSID =
      "c3f2b2f2-7580-4619-8095-702c3fcf15b0";
  static const String characteristicPASS =
      "a68d0d0a-f859-4be4-b6af-8f0e9b640272";
  static const String characteristicTOKEN =
      "5d627dd8-ef0d-48e2-9958-f4064806b03f";
  static const String characteristicURL =
      "e6292ee1-d35f-4914-818d-51f9bc8d6a3c";
  //after writing in the DONE characteristic the arduino device disconnects
  static const String characteristicDONE =
      "c4c631d9-ae46-46ad-bc44-d3fd55a6f8bf";

  final void Function() onSentComplete;
  const SendingDataStep(
      {Key? key,
      required this.device,
      required this.ssid,
      required this.password,
      required this.gardenToken,
      required this.url,
      required this.onSentComplete})
      : super(key: key);

  @override
  State<SendingDataStep> createState() => _SendingDataStepState();
}

class _SendingDataStepState extends State<SendingDataStep> {
  Future<void> writeToCharacteritstic() async {
    // ignore: unused_local_variable
    int writtenCharacteristicsNr = 0;
    bool done = false;
    bool doneSearchingCharacteristics = false;
    if (widget.device != null) {
      List<BluetoothService> services =
          await widget.device!.discoverServices().whenComplete(() {
        doneSearchingCharacteristics = true;
      });
      if (doneSearchingCharacteristics) {
        services.forEach((service) async {
          if (service.uuid.toString() == SendingDataStep.serviceUID) {
            for (BluetoothCharacteristic c in service.characteristics) {
              switch (c.uuid.toString()) {
                case SendingDataStep.characteristicSSID:
                  {
                    await c.write(utf8.encode(widget.ssid));
                    writtenCharacteristicsNr++;
                  }
                  break;

                case SendingDataStep.characteristicPASS:
                  {
                    await c.write(utf8.encode(widget.password));
                    writtenCharacteristicsNr++;
                  }
                  break;

                case SendingDataStep.characteristicTOKEN:
                  {
                    await c.write(utf8.encode(widget.gardenToken));

                    writtenCharacteristicsNr++;
                  }
                  break;

                case SendingDataStep.characteristicURL:
                  {
                    await c.write(utf8.encode(widget.url));
                    writtenCharacteristicsNr++;
                  }
                  break;

                case SendingDataStep.characteristicDONE:
                  {
                    await c.write(utf8.encode("Done")).whenComplete(() {
                      done = true;
                    });
                  }
                  break;

                default:
                  break;
              }
            }
          }

          if (done) {
            print("DONE");
            widget.onSentComplete();
          }
        });
      }
    }
  }

  @override
  void initState() {
    writeToCharacteritstic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(top: 38.0),
          child: Text(
            'Configuring your ArduinoGarden device',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 38.0),
          child: LoadingAnimationWidget.dotsTriangle(
            color: Colors.pink,
            size: 124,
          ),
        ),
      ],
    );
  }
}

class SetupCompleteStep extends StatelessWidget {
  final void Function() onSetupDone;
  const SetupCompleteStep({Key? key, required this.onSetupDone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(top: 38.0),
          child: Text(
            'Device Setup Complete!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 34,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 16.0, bottom: 18),
          child: Icon(
            Icons.check_circle_outline_outlined,
            color: Colors.green.shade400,
            size: 56.0,
          ),
        ),
        MaterialButton(
          padding:
              EdgeInsets.only(bottom: 12.0, top: 12.0, left: 34, right: 34),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          color: Colors.pink,
          child: const Text(
            'Done',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          onPressed: () => onSetupDone(),
        ),
      ],
    );
  }
}

class BluetoothCheckStep extends StatefulWidget {
  final Function() onBluetoothEnabled;
  const BluetoothCheckStep({Key? key, required this.onBluetoothEnabled})
      : super(key: key);

  @override
  State<BluetoothCheckStep> createState() => _BluetoothCheckStepState();
}

class _BluetoothCheckStepState extends State<BluetoothCheckStep> {
  @override
  void initState() {
    late StreamSubscription subscription;
    subscription = FlutterBlue.instance.state.listen((event) {
      if (event == BluetoothState.on) {
        subscription.cancel();
        widget.onBluetoothEnabled();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: 38.0),
          child: Text(
            'Please turn on Bluetooth',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red.shade400,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 38.0),
          child: LoadingAnimationWidget.threeArchedCircle(
            color: Colors.pink,
            size: 80,
          ),
        ),
        MaterialButton(
          padding:
              EdgeInsets.only(bottom: 12.0, top: 12.0, left: 34, right: 34),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          color: Colors.pink,
          child: const Text(
            'Enable Bluetooth',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          onPressed: () => AppSettings.openBluetoothSettings(),
        ),
      ],
    );
  }
}
