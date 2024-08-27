import 'package:flutter/material.dart';
import 'package:mobile_pos/constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'chart_data.dart';
import 'package:mobile_pos/model/dashboard_overview_model.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;

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
            primaryXAxis: const CategoryAxis(
              axisLine: AxisLine(width: 0), // Remove bottom axis line
              majorGridLines: MajorGridLines(width: 0), //// Remove vertical grid lines// Make labels transparent
              majorTickLines: MajorTickLines(size: 0),
            ),
            primaryYAxis: const NumericAxis(
              axisLine: AxisLine(width: 0), // Remove left axis line
              majorGridLines: MajorGridLines(
                color: Color(0xffD1D5DB),
                dashArray: [5, 5], // Creates a dotted line pattern for horizontal grid lines
              ),
            ),
            plotAreaBorderWidth: 0,
            series: <CartesianSeries<ChartData, String>>[
              ColumnSeries<ChartData, String>(
                dataSource: chartData,
                spacing: 0.3,
                width: 0.5,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                //name: 'Sales',
                name: lang.S.of(context).sales,
                dataLabelSettings: const DataLabelSettings(isVisible: false),
                color: Colors.green,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)
                ),
              ),
              ColumnSeries<ChartData, String>(
                dataSource: chartData,
                width: 0.5,
                spacing: 0.3,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y1,
               // name: 'Purchase',
                name: lang.S.of(context).purchase,
                color: kMainColor,
                dataLabelSettings: const DataLabelSettings(isVisible: false),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
                ),
              ),
            ],
          )
          ,
          // child: SfCartesianChart(
          //   primaryXAxis: const CategoryAxis(  majorGridLines: MajorGridLines(width: 0),),
          //   primaryYAxis: const NumericAxis(  majorGridLines: MajorGridLines(width: 0),),
          //   series: <CartesianSeries<ChartData, String>>[
          //     ColumnSeries<ChartData, String>(
          //       dataSource: chartData,
          //       width: 0.2,
          //       xValueMapper: (ChartData data, _) => data.x,
          //       yValueMapper: (ChartData data, _) => data.y,
          //       name: 'Sales',
          //       dataLabelSettings: const DataLabelSettings(isVisible: false),
          //       borderRadius:  BorderRadius.circular(10),
          //       color: Colors.green,
          //     ),
          //     ColumnSeries<ChartData, String>(
          //       dataSource: chartData,
          //       width: 0.2,
          //       xValueMapper: (ChartData data, _) => data.x,
          //       yValueMapper: (ChartData data, _) => data.y1,
          //       name: 'Purchase',
          //       color: kMainColor,
          //       dataLabelSettings: const DataLabelSettings(isVisible: false),
          //       borderRadius:  BorderRadius.circular(10),
          //     ),
          //   ],
          // ),
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
