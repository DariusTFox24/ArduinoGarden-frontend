import 'package:arduino_garden/models/garden.dart';
import 'package:arduino_garden/models/gardenHistory.dart';
import 'package:arduino_garden/widgets/grid_card.dart';
import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../config/state_handler.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class GraphData {
  GraphData(this.time, this.value);
  final DateTime time;
  final double value;
}

List<GraphData> setGraphDataTemp(
    List<GardenHistory> gardenHistoryList, String date) {
  debugPrint(' setGraphDataTemp ');
  final List<GraphData> _chartDataTemp = [];
  debugPrint(date);
  debugPrint(' vs ');

  for (GardenHistory gh in gardenHistoryList) {
    debugPrint(gh.dateAndTime.toString().split(" ")[0]);
    if ((gh.dateAndTime.toString().split(" ")[0]) == date) {
      _chartDataTemp.add(GraphData(gh.dateAndTime, gh.gardenData.temperature));
    }
  }

  return _chartDataTemp;
}

List<GraphData> setGraphDataHumidity(
    List<GardenHistory> gardenHistoryList, String date) {
  debugPrint(' setGraphDataHumidity ');
  final List<GraphData> _chartDataHumidity = [];
  debugPrint(date);
  debugPrint(' vs ');

  for (GardenHistory gh in gardenHistoryList) {
    debugPrint(gh.dateAndTime.toString().split(" ")[0]);
    if ((gh.dateAndTime.toString().split(" ")[0]) == date) {
      _chartDataHumidity
          .add(GraphData(gh.dateAndTime, gh.gardenData.humidity.toDouble()));
    }
  }

  return _chartDataHumidity;
}

List<GraphData> setGraphDataLight(
    List<GardenHistory> gardenHistoryList, String date) {
  debugPrint(' setGraphDataLight ');
  final List<GraphData> _chartDataLight = [];
  debugPrint(date);
  debugPrint(' vs ');

  for (GardenHistory gh in gardenHistoryList) {
    debugPrint(gh.dateAndTime.toString().split(" ")[0]);
    if ((gh.dateAndTime.toString().split(" ")[0]) == date) {
      _chartDataLight.add(
          GraphData(gh.dateAndTime, gh.gardenData.lightIntensity.toDouble()));
    }
  }

  return _chartDataLight;
}

List<GraphData> setGraphDataSolar(
    List<GardenHistory> gardenHistoryList, String date) {
  debugPrint(' setGraphDataSolar ');
  final List<GraphData> _chartDataSolar = [];
  debugPrint(date);
  debugPrint(' vs ');

  for (GardenHistory gh in gardenHistoryList) {
    debugPrint(gh.dateAndTime.toString().split(" ")[0]);
    if ((gh.dateAndTime.toString().split(" ")[0]) == date) {
      _chartDataSolar
          .add(GraphData(gh.dateAndTime, gh.gardenData.solarVoltage));
    }
  }

  return _chartDataSolar;
}

class _GraphPageState extends State<GraphPage> {
  late TooltipBehavior _tooltipBehavior;
  List<GardenHistory> gardenHistoryList = [];
  late List<GraphData> _chartDataTemp;
  late List<GraphData> _chartDataHumidity;
  late List<GraphData> _chartDataLight;
  late List<GraphData> _chartDataSolar;
  late DateTime selectedDateTemp = DateTime.now();
  late DateTime selectedDateHumidity = DateTime.now();
  late DateTime selectedDateLight = DateTime.now();
  late DateTime selectedDateSolar = DateTime.now();
  bool loaded = false;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: false);
    super.initState();

    () async {
      await Provider.of<StateHandler>(context, listen: false)
          .updateGardenHistory();
      setState(() {
        this.gardenHistoryList =
            Provider.of<StateHandler>(context, listen: false).gardenHistory;
        debugPrint('gardenHistoryList:');
        debugPrint(this.gardenHistoryList.toString());

        this._chartDataTemp = setGraphDataTemp(this.gardenHistoryList,
            this.selectedDateTemp.toString().split(" ")[0]);
        this._chartDataHumidity = setGraphDataHumidity(this.gardenHistoryList,
            this.selectedDateHumidity.toString().split(" ")[0]);
        this._chartDataLight = setGraphDataLight(this.gardenHistoryList,
            this.selectedDateLight.toString().split(" ")[0]);
        this._chartDataSolar = setGraphDataSolar(this.gardenHistoryList,
            this.selectedDateSolar.toString().split(" ")[0]);
        this.loaded = true;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Center(
          child: ListView(children: [
            if (!loaded) ...{
              Container(
                padding: EdgeInsets.only(top: 38.0),
                child: LoadingAnimationWidget.halfTriangleDot(
                  color: Colors.pink.shade400,
                  size: 124,
                ),
              ),
            } else ...{
              GridCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: SfCartesianChart(
                        title: ChartTitle(text: 'Temperature History'),
                        legend: Legend(isVisible: false),
                        tooltipBehavior: _tooltipBehavior,
                        primaryXAxis: DateTimeAxis(
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          dateFormat: DateFormat.Hm(),
                        ),
                        primaryYAxis: NumericAxis(labelFormat: '{value}??C'),
                        series: <ChartSeries>[
                          LineSeries<GraphData, DateTime>(
                            name: 'Temperature History',
                            enableTooltip: true,
                            dataSource: _chartDataTemp,
                            xValueMapper: (GraphData graph, _) => graph.time,
                            yValueMapper: (GraphData graph, _) => graph.value,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                          )
                        ],
                      ),
                      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, bottom: 0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            onPressed: () {
                              setState(() {
                                this.selectedDateTemp = this
                                    .selectedDateTemp
                                    .subtract(const Duration(days: 1));
                                this._chartDataTemp = setGraphDataTemp(
                                    this.gardenHistoryList,
                                    this
                                        .selectedDateTemp
                                        .toString()
                                        .split(" ")[0]);
                              });
                            },
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                            ),
                            color: Colors.pink,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Text(
                            selectedDateTemp.toString().split(" ")[0],
                            style: TextStyle(color: Colors.pink, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 12.0, bottom: 0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            onPressed: () {
                              setState(() {
                                this.selectedDateTemp = this
                                    .selectedDateTemp
                                    .add(const Duration(days: 1));
                                this._chartDataTemp = setGraphDataTemp(
                                    this.gardenHistoryList,
                                    this
                                        .selectedDateTemp
                                        .toString()
                                        .split(" ")[0]);
                              });
                            },
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                            color: Colors.pink,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GridCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: SfCartesianChart(
                        title: ChartTitle(text: 'Humidity History'),
                        legend: Legend(isVisible: false),
                        tooltipBehavior: _tooltipBehavior,
                        primaryXAxis: DateTimeAxis(
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          dateFormat: DateFormat.Hm(),
                        ),
                        primaryYAxis: NumericAxis(labelFormat: '{value}%'),
                        series: <ChartSeries>[
                          LineSeries<GraphData, DateTime>(
                            name: 'Humidity History',
                            enableTooltip: true,
                            dataSource: _chartDataHumidity,
                            xValueMapper: (GraphData graph, _) => graph.time,
                            yValueMapper: (GraphData graph, _) => graph.value,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                          )
                        ],
                      ),
                      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, bottom: 0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            onPressed: () {
                              setState(() {
                                this.selectedDateHumidity = this
                                    .selectedDateHumidity
                                    .subtract(const Duration(days: 1));
                                this._chartDataHumidity = setGraphDataHumidity(
                                    this.gardenHistoryList,
                                    this
                                        .selectedDateHumidity
                                        .toString()
                                        .split(" ")[0]);
                              });
                            },
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                            ),
                            color: Colors.pink,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Text(
                            selectedDateHumidity.toString().split(" ")[0],
                            style: TextStyle(color: Colors.pink, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 12.0, bottom: 0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            onPressed: () {
                              setState(() {
                                this.selectedDateHumidity = this
                                    .selectedDateHumidity
                                    .add(const Duration(days: 1));
                                this._chartDataHumidity = setGraphDataHumidity(
                                    this.gardenHistoryList,
                                    this
                                        .selectedDateHumidity
                                        .toString()
                                        .split(" ")[0]);
                              });
                            },
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                            color: Colors.pink,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GridCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: SfCartesianChart(
                        title: ChartTitle(text: 'Light Intensity History'),
                        legend: Legend(isVisible: false),
                        tooltipBehavior: _tooltipBehavior,
                        primaryXAxis: DateTimeAxis(
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          dateFormat: DateFormat.Hm(),
                        ),
                        primaryYAxis: NumericAxis(labelFormat: '{value}%'),
                        series: <ChartSeries>[
                          LineSeries<GraphData, DateTime>(
                            name: 'Light Intensity History',
                            enableTooltip: true,
                            dataSource: _chartDataLight,
                            xValueMapper: (GraphData graph, _) => graph.time,
                            yValueMapper: (GraphData graph, _) => graph.value,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                          )
                        ],
                      ),
                      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, bottom: 0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            onPressed: () {
                              setState(() {
                                this.selectedDateLight = this
                                    .selectedDateLight
                                    .subtract(const Duration(days: 1));
                                this._chartDataLight = setGraphDataLight(
                                    this.gardenHistoryList,
                                    this
                                        .selectedDateLight
                                        .toString()
                                        .split(" ")[0]);
                              });
                            },
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                            ),
                            color: Colors.pink,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Text(
                            selectedDateLight.toString().split(" ")[0],
                            style: TextStyle(color: Colors.pink, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 12.0, bottom: 0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            onPressed: () {
                              setState(() {
                                this.selectedDateLight = this
                                    .selectedDateLight
                                    .add(const Duration(days: 1));

                                this._chartDataLight = setGraphDataLight(
                                    this.gardenHistoryList,
                                    this
                                        .selectedDateLight
                                        .toString()
                                        .split(" ")[0]);
                              });
                            },
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                            color: Colors.pink,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GridCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: SfCartesianChart(
                        title: ChartTitle(text: 'Solar Power History'),
                        legend: Legend(isVisible: false),
                        tooltipBehavior: _tooltipBehavior,
                        primaryXAxis: DateTimeAxis(
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          dateFormat: DateFormat.Hm(),
                        ),
                        primaryYAxis: NumericAxis(labelFormat: '{value}V'),
                        series: <ChartSeries>[
                          LineSeries<GraphData, DateTime>(
                            name: 'Solar Power History',
                            enableTooltip: true,
                            dataSource: _chartDataSolar,
                            xValueMapper: (GraphData graph, _) => graph.time,
                            yValueMapper: (GraphData graph, _) => graph.value,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                          )
                        ],
                      ),
                      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, bottom: 0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            onPressed: () {
                              setState(() {
                                this.selectedDateSolar = this
                                    .selectedDateSolar
                                    .subtract(const Duration(days: 1));

                                this._chartDataSolar = setGraphDataSolar(
                                    this.gardenHistoryList,
                                    this
                                        .selectedDateSolar
                                        .toString()
                                        .split(" ")[0]);
                              });
                            },
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                            ),
                            color: Colors.pink,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Text(
                            selectedDateSolar.toString().split(" ")[0],
                            style: TextStyle(color: Colors.pink, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 12.0, bottom: 0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            onPressed: () {
                              setState(() {
                                this.selectedDateSolar = this
                                    .selectedDateSolar
                                    .add(const Duration(days: 1));
                                this._chartDataSolar = setGraphDataSolar(
                                    this.gardenHistoryList,
                                    this
                                        .selectedDateSolar
                                        .toString()
                                        .split(" ")[0]);
                              });
                            },
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                            color: Colors.pink,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            },
          ]),
        ),
      ),
    );
  }
}
