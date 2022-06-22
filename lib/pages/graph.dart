import 'package:arduino_garden/widgets/grid_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../config/config.dart';
import '../config/state_handler.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  State<GraphPage> createState() => _GraphPageState();
}

///JSUT DEMO FOR GRAPHS DELETUS AFTER
class GraphData {
  GraphData(this.time, this.value);
  final double time;
  final double value;
}

List<GraphData> getGraphDataToCharts() {
  final List<GraphData> chartData = [
    GraphData(10, 18.5),
    GraphData(11, 20.2),
    GraphData(12, 21.5),
    GraphData(13, 23.1),
    GraphData(14, 24.2),
    GraphData(15, 23.6),
    GraphData(16, 24.7)
  ];

  //TODO: make charts show only last 7 recorded values, swipe right on card
  // shows previous 7 and swipe left shows next 7 if available

  return chartData;
}

class _GraphPageState extends State<GraphPage> {
  late List<GraphData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getGraphDataToCharts();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
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
            GridCard(
              child: Container(
                child: SfCartesianChart(
                  title: ChartTitle(text: 'Temperature History'),
                  legend: Legend(isVisible: false),
                  tooltipBehavior: _tooltipBehavior,
                  primaryXAxis:
                      NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                  primaryYAxis: NumericAxis(labelFormat: '{value}°C'),
                  series: <ChartSeries>[
                    LineSeries<GraphData, double>(
                      name: 'Temperature History',
                      enableTooltip: true,
                      dataSource: _chartData,
                      xValueMapper: (GraphData graph, _) => graph.time,
                      yValueMapper: (GraphData graph, _) => graph.value,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    )
                  ],
                ),
                margin: const EdgeInsets.fromLTRB(10.0, 18.0, 22.0, 6.0),
              ),
            ),
            GridCard(
              child: Container(
                child: SfCartesianChart(
                  title: ChartTitle(text: 'Humidity History'),
                  legend: Legend(isVisible: false),
                  tooltipBehavior: _tooltipBehavior,
                  primaryXAxis:
                      NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                  primaryYAxis: NumericAxis(labelFormat: '{value}°C'),
                  series: <ChartSeries>[
                    LineSeries<GraphData, double>(
                      name: 'Humidity History',
                      enableTooltip: true,
                      dataSource: _chartData,
                      xValueMapper: (GraphData graph, _) => graph.time,
                      yValueMapper: (GraphData graph, _) => graph.value,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    )
                  ],
                ),
                margin: const EdgeInsets.fromLTRB(10.0, 18.0, 22.0, 6.0),
              ),
            ),
            GridCard(
              child: Container(
                child: SfCartesianChart(
                  title: ChartTitle(text: 'Light Intensity History'),
                  legend: Legend(isVisible: false),
                  tooltipBehavior: _tooltipBehavior,
                  primaryXAxis:
                      NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                  primaryYAxis: NumericAxis(labelFormat: '{value}°C'),
                  series: <ChartSeries>[
                    LineSeries<GraphData, double>(
                      name: 'Light Intensity History',
                      enableTooltip: true,
                      dataSource: _chartData,
                      xValueMapper: (GraphData graph, _) => graph.time,
                      yValueMapper: (GraphData graph, _) => graph.value,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    )
                  ],
                ),
                margin: const EdgeInsets.fromLTRB(10.0, 18.0, 22.0, 6.0),
              ),
            ),
            GridCard(
              child: Container(
                child: SfCartesianChart(
                  title: ChartTitle(text: 'Solar Power History'),
                  legend: Legend(isVisible: false),
                  tooltipBehavior: _tooltipBehavior,
                  primaryXAxis:
                      NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                  primaryYAxis: NumericAxis(labelFormat: '{value}°C'),
                  series: <ChartSeries>[
                    LineSeries<GraphData, double>(
                      name: 'Solar Power History',
                      enableTooltip: true,
                      dataSource: _chartData,
                      xValueMapper: (GraphData graph, _) => graph.time,
                      yValueMapper: (GraphData graph, _) => graph.value,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    )
                  ],
                ),
                margin: const EdgeInsets.fromLTRB(10.0, 18.0, 22.0, 6.0),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
