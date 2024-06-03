import 'package:flutter/material.dart';
import 'package:mobile_pos/constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'chart_data.dart';

class NumericAxisChart extends StatefulWidget {
  const NumericAxisChart({Key? key}) : super(key: key);

  @override
  State<NumericAxisChart> createState() => _NumericAxisChartState();
}

class _NumericAxisChartState extends State<NumericAxisChart> {
  final List<ChartData> chartData = [
    ChartData('Jan', 235, 240),
    ChartData('Feb', 242, 250),
    ChartData('Mar', 320, 280),
    ChartData('Apr', 360, 355),
    ChartData('May', 270, 245),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: kWhite,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(),
            series: <CartesianSeries<ChartData, String>>[
              ColumnSeries<ChartData, String>(
                dataSource: chartData,
                width: 0.2,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                name: 'Sales',
                dataLabelSettings: const DataLabelSettings(isVisible: false),
                color: Colors.green,
              ),
              ColumnSeries<ChartData, String>(
                dataSource: chartData,
                width: 0.2,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y1,
                name: 'Purchase',
                color: kMainColor,
                dataLabelSettings: const DataLabelSettings(isVisible: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1);

  final String x;
  final double y;
  final double y1;
}
