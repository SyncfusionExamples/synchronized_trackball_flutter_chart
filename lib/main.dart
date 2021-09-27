import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() => runApp(SynchronizedTrackball());

class SynchronizedTrackball extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Synchronized Zoom',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: <Widget>[
              Container(
                height: 280,
                child: FirstChart(),
              ),
              Container(
                height: 280,
                child: SecondChart(),
              ),
            ]),
          )),
    );
  }
}

TrackballBehavior trackBall1 =
    TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap);
TrackballBehavior trackBall2 =
    TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap);

class FirstChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FirstChartState();
  }
}

class FirstChartState extends State<FirstChart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        onChartTouchInteractionMove: (ChartTouchInteractionArgs args) {
          trackBall2.show(args.position.dx, args.position.dy, 'pixel');
        },
        backgroundColor: Colors.white,
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: 'Chart 1'),
        trackballBehavior: trackBall1,
        series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
              dataSource: <SalesData>[
                SalesData('Jan', 21),
                SalesData('Feb', 24),
                SalesData('Mar', 35),
                SalesData('Apr', 38),
                SalesData('May', 54),
                SalesData('Jun', 21),
                SalesData('Jul', 24),
                SalesData('Aug', 35),
                SalesData('Sep', 38),
                SalesData('Oct', 54),
                SalesData('Nov', 38),
                SalesData('Dec', 54)
              ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales)
        ]);
  }
}

class SecondChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SecondChartState();
  }
}

class SecondChartState extends State<SecondChart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        onChartTouchInteractionMove: (ChartTouchInteractionArgs args) {
          trackBall1.show(args.position.dx, args.position.dy, 'pixel');
        },
        backgroundColor: Colors.white,
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: 'Chart 2'),
        trackballBehavior: trackBall2,
        series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
              dataSource: <SalesData>[
                SalesData('Jan', 21),
                SalesData('Feb', 24),
                SalesData('Mar', 35),
                SalesData('Apr', 38),
                SalesData('May', 54),
                SalesData('Jun', 21),
                SalesData('Jul', 24),
                SalesData('Aug', 35),
                SalesData('Sep', 38),
                SalesData('Oct', 54),
                SalesData('Nov', 38),
                SalesData('Dec', 54)
              ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales)
        ]);
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
