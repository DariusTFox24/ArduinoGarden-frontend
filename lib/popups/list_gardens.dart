import 'package:arduino_garden/config/config.dart';
import 'package:arduino_garden/config/state_handler.dart';
import 'package:arduino_garden/popups/edit_garden.dart';
import 'package:arduino_garden/popups/link_garden.dart';
import 'package:arduino_garden/widgets/grid_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListGardens extends StatefulWidget {
  const ListGardens({Key? key}) : super(key: key);

  @override
  State<ListGardens> createState() => _ListGardensState();
}

class _ListGardensState extends State<ListGardens> {
  @override
  Widget build(BuildContext context) {
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
                'Your Gardens',
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
                              Provider.of<StateHandler>(context)
                                  .gardens[index]
                                  .name,
                              style: TextStyle(
                                color: Color.fromARGB(255, 52, 37, 19),
                                fontWeight: FontWeight.w400,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                onPressed: () async {
                                  await api.deleteGarden(
                                    Provider.of<StateHandler>(context,
                                            listen: false)
                                        .token!,
                                    Provider.of<StateHandler>(context,
                                            listen: false)
                                        .gardens[index]
                                        .id,
                                  );
                                  Provider.of<StateHandler>(context,
                                          listen: false)
                                      .updateUser();
                                  Provider.of<StateHandler>(context,
                                          listen: false)
                                      .setGardenIndex(0);
                                  Provider.of<StateHandler>(context,
                                          listen: false)
                                      .setCurrentGarden(
                                          Provider.of<StateHandler>(context,
                                                  listen: false)
                                              .gardens[0]);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Delete',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                                color: Colors.pink,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 4.0),
                              //   child: MaterialButton(
                              //     shape: RoundedRectangleBorder(
                              //         borderRadius:
                              //             BorderRadius.circular(12.0)),
                              //     onPressed: () async {
                              //       Navigator.of(context).pop();
                              //       showDialog(
                              //           context: context,
                              //           builder: (context) {
                              //             return EditGarden(
                              //               garden: Provider.of<StateHandler>(
                              //                       context,
                              //                       listen: false)
                              //                   .gardens[index],
                              //             );
                              //           });
                              //     },
                              //     child: Text(
                              //       'Edit',
                              //       style: TextStyle(
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //     color: Colors.pink,
                              //   ),
                              // ),
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
                                          return LinkGarden(
                                            garden: Provider.of<StateHandler>(
                                                    context,
                                                    listen: false)
                                                .gardens[index],
                                          );
                                        });
                                  },
                                  child: Text(
                                    'Link',
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
                    itemCount:
                        Provider.of<StateHandler>(context).gardens.length,
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
