import 'package:arduino_garden/config/state_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/login.dart';
import '../widgets/grid_card.dart';

class ConfirmSignOut extends StatefulWidget {
  const ConfirmSignOut({Key? key}) : super(key: key);

  @override
  State<ConfirmSignOut> createState() => _ConfirmSignOutState();
}

class _ConfirmSignOutState extends State<ConfirmSignOut> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      content: GridCard(
        aspectRatio: 3.0 / 2.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 18.0, left: 8, right: 8),
              child: Text(
                'Are you sure you want to sign out?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 26,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: MaterialButton(
                    padding: EdgeInsets.only(
                        bottom: 10.0, top: 10.0, left: 24, right: 24),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    color: Colors.pink,
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                  child: MaterialButton(
                    padding: EdgeInsets.only(
                        bottom: 10.0, top: 10.0, left: 24, right: 24),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    color: Colors.pink,
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () async {
                      final route = MaterialPageRoute(
                          builder: (context) => const Login());
                      final deleteToken =
                          Provider.of<StateHandler>(context, listen: false)
                              .deleteToken;
                      Navigator.of(context)
                          .pushAndRemoveUntil(route, (route) => false);
                      await route.didPush();
                      await deleteToken();
                      // Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
