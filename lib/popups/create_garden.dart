import 'package:arduino_garden/config/config.dart';
import 'package:arduino_garden/config/state_handler.dart';
import 'package:arduino_garden/models/garden.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../widgets/grid_card.dart';

class CreateGarden extends StatefulWidget {
  const CreateGarden({Key? key}) : super(key: key);

  @override
  State<CreateGarden> createState() => _CreateGardenState();
}

class _CreateGardenState extends State<CreateGarden> {
  bool _validateName = false;
  @override
  Widget build(BuildContext context) {
    final gardenName = TextEditingController();

    return AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: GridCard(
        aspectRatio: 3.0 / 3.0,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Text(
                'Create New Garden',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 60.0, bottom: 8.0, left: 8.0, right: 8.0),
              child: TextField(
                controller: gardenName,
                decoration: InputDecoration(
                  hintText: 'Garden Name',
                  errorText: _validateName ? 'Value Can\'t Be Empty' : null,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
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
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    _validateName = gardenName.text.isEmpty;
                  });

                  if (gardenName.text.isEmpty == false) {
                    Garden garden = await api.createGarden(
                        Provider.of<StateHandler>(context, listen: false)
                            .token!,
                        gardenName.text);
                    await Provider.of<StateHandler>(context, listen: false)
                        .updateUser();

                    if (kDebugMode) {
                      Fluttertoast.showToast(
                        msg: "Token: " + garden.gardenToken,
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    }

                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
