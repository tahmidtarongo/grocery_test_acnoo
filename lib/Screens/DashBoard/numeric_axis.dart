import 'package:flutter/material.dart';
import 'package:mobile_pos/constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'chart_data.dart';
import 'package:mobile_pos/model/dashboard_overview_model.dart';

class NumericAxisChart extends StatefulWidget {
  const NumericAxisChart({Key? key, required this.model}) : super(key: key);

  final DashboardOverviewModel model;

  @override
  State<NumericAxisChart> createState() => _NumericAxisChartState();
}

class _NumericAxisChartState extends State<NumericAxisChart> {
  final List<ChartData> chartData = [];

  @override
  void initState() {
    // TODO: implement initState
    getData(widget.model);
    super.initState();
  }

  getData(DashboardOverviewModel model) {
    for (int i = 0; i < model.data!.sales!.length; i++) {
      chartData.add(ChartData(
          model.data!.sales![i].date!,
          model.data!.sales![i].amount!.toDouble(),
          model.data!.purchases![i].amount!.toDouble()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: kWhite,
          child: SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
            primaryYAxis: const NumericAxis(),
            series: <CartesianSeries<ChartData, String>>[
              ColumnSeries<ChartData, String>(
                dataSource: chartData,
                width: 0.2,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                name: 'Sales',
                dataLabelSettings: const DataLabelSettings(isVisible: false),
                borderRadius:  BorderRadius.circular(10),
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
                borderRadius:  BorderRadius.circular(10),
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
