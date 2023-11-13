import 'package:bin_trade/setting/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'bloc/home/home_bloc.dart';
import 'models/charts.dart';

class ChartsWidget extends StatefulWidget {
  const ChartsWidget({super.key});

  @override
  State<ChartsWidget> createState() => _ChartsWidgetState();
}

class _ChartsWidgetState extends State<ChartsWidget> {
  @override
  void initState() {
    super.initState();
    _trackballBehavior = TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap);
  }

  late TrackballBehavior _trackballBehavior;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.charts != current.charts,
      builder: (context, state) {
        return SfCartesianChart(
          trackballBehavior: _trackballBehavior,
          borderColor: menuIconsColor,
          backgroundColor: Colors.black,
          series: [
            CandleSeries<ChartSampleData, DateTime>(
                dataSource: state.charts,
                xValueMapper: (x, y) => x.x,
                lowValueMapper: (x, y) => x.close,
                highValueMapper: (x, y) => x.open,
                openValueMapper: (x, y) => x.open,
                bearColor: Colors.green,
                bullColor: Colors.red,
                
                closeValueMapper: (x, y) => x.close),
          ],

          primaryXAxis: DateTimeAxis(
            majorGridLines: MajorGridLines(color: Colors.grey)
          ),
          primaryYAxis: NumericAxis(
            majorGridLines: MajorGridLines(color: Colors.grey)
),
        );
      },
    );
  }
}
