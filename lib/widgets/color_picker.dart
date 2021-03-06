import 'dart:ui';
import 'package:arduino_garden/config/config.dart';
import 'package:arduino_garden/config/state_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'grid_card.dart';

class ColorPickerWidget extends StatefulWidget {
  final bool rgbStatus;
  final Color rgbColor;
  final Widget initialIcon;

  const ColorPickerWidget({
    Key? key,
    required this.rgbStatus,
    required this.rgbColor,
    required this.initialIcon,
  }) : super(key: key);

  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  late bool rgbStatus;
  late Color rgbColor;
  int? rgbMode;
  bool exit = false;
  late Color newColor;

  Widget get rgbModeIcon {
    switch (rgbMode) {
      case 0:
        return Icon(Icons.wb_iridescent);
      case 1:
        return Icon(Icons.looks);
      case 2:
        return Icon(Icons.blur_linear);
      default:
        return widget.initialIcon;
    }
  }

  @override
  void initState() {
    rgbStatus = widget.rgbStatus;
    rgbColor = widget.rgbColor;
    newColor = rgbColor;
    exit = false;

    setState(() {
      rgbMode = Provider.of<StateHandler>(context, listen: false)
          .currentGarden!
          .rgb
          .mode;
    });

    super.initState();
  }

  void changeRgbColor(Color newColor) {

    print(api.userUpdateData(
        Provider.of<StateHandler>(context, listen: false).token!,
        Provider.of<StateHandler>(context, listen: false).currentGarden!.id,
        {'RGB.color': "${newColor.red},${newColor.green},${newColor.blue}"}));
    setState(() {
      rgbColor = newColor;
    });
  }

  void changeRgbMode(int newVal) {
 
    api.userUpdateData(
        Provider.of<StateHandler>(context, listen: false).token!,
        Provider.of<StateHandler>(context, listen: false).currentGarden!.id,
        {'RGB.mode': newVal});
    setState(() {
      rgbMode = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: exit ? 0 : 6),
      duration: const Duration(milliseconds: 300),
      builder: (context, sigma, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: sigma,
            sigmaY: sigma,
          ),
          child: child,
        );
      },
      child: WillPopScope(
        onWillPop: () {
          setState(() {
            exit = true;
          });
          changeRgbColor(newColor);
          return Future.value(true);
        },
        child: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).maybePop(newColor);
            },
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 128,
                        width: 128,
                        child: Hero(
                          tag: "rgbButton",
                          child: GridCardButton(
                            alpha: rgbStatus ? 255 : 180,
                            onTap: () {},
                            icon: rgbModeIcon,
                            enabled: rgbStatus,
                            iconColor: rgbColor,
                            onLongPress: () {},
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: exit ? 0 : 1,
                      curve: Curves.easeIn,
                      duration: const Duration(milliseconds: 300),
                      child: GridCard(
                        aspectRatio: 3 / 2,
                        alpha: 230,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: SlidePicker(
                            pickerColor: rgbColor,
                            onColorChanged: (color) {
                              newColor = color;
                            },
                            enableAlpha: false,
                            displayThumbColor: true,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GridCardButton(
                            icon: ColorFiltered(
                              child: Image.asset(
                                "assets/rainbow.png",
                                alignment: Alignment.center,
                              ),
                              colorFilter: ColorFilter.mode(
                                  Colors.blueGrey.shade800.withAlpha(140),
                                  (rgbMode != 1)
                                      ? BlendMode.srcATop
                                      : BlendMode.dst),
                            ),
                            onTap: () {
                              changeRgbMode(1);
                            },
                            alpha: (rgbMode == 1) ? 255 : 180,
                            enabled: (rgbMode == 1),
                            onLongPress: () {},
                          ),
                        ),
                        Expanded(
                          child: GridCardButton(
                            icon: Icon(Icons.wb_iridescent),
                            onTap: () {
                              changeRgbMode(0);
                            },
                            alpha: (rgbMode == 0) ? 255 : 180,
                            enabled: (rgbMode == 0),
                            iconColor: rgbColor,
                            onLongPress: () {},
                          ),
                        ),
                        Expanded(
                          child: GridCardButton(
                            icon: Icon(Icons.blur_linear),
                            onTap: () {
                              changeRgbMode(2);
                            },
                            alpha: (rgbMode == 2) ? 255 : 180,
                            enabled: (rgbMode == 2),
                            iconColor: Colors.blue,
                            onLongPress: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
