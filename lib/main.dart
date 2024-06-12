import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() => runApp(const SynchronizedTrackball());

class SynchronizedTrackball extends StatelessWidget {
  const SynchronizedTrackball({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Synchronized Zoom',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 280,
                child: FirstChart(),
              ),
              SizedBox(
                height: 280,
                child: SecondChart(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Trackball behavior instances for the two charts.
TrackballBehavior trackBall1 =
    TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap);
TrackballBehavior trackBall2 =
    TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap);

// Controllers for accessing and manipulating the series in the charts.
ChartSeriesController? _secondChartController;
ChartSeriesController? _firstChartController;

// Variables to store the trackball positions for synchronization.
Offset? _firstPosition;
Offset? _secondPosition;

class FirstChart extends StatefulWidget {
  const FirstChart({super.key});

  @override
  State<StatefulWidget> createState() {
    return FirstChartState();
  }
}

class FirstChartState extends State<FirstChart> {
  // Declaring a field to check whether the user is interacting with the chart.
  bool _isInteractive = false;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      // Set to true when user touch on the chart.
      onChartTouchInteractionDown: (ChartTouchInteractionArgs tapArgs) {
        _isInteractive = true;
      },
      // Set to false when user touched the chart and hidden the visible Trackball.
      onChartTouchInteractionUp: (ChartTouchInteractionArgs tapArgs) {
        _isInteractive = false;
        trackBall2.hide();
      },
      // Displayed the trackball when tap on the chart.
      onTrackballPositionChanging: (TrackballArgs trackballArgs) {
        if (_isInteractive) {
          _secondPosition = _secondChartController!.pointToPixel(
            trackballArgs.chartPointInfo.chartPoint!,
          );
          trackBall2.show(_secondPosition!.dx, _secondPosition!.dy, 'pixel');
        }
      },
      backgroundColor: Colors.white,
      primaryXAxis: const CategoryAxis(),
      title: const ChartTitle(text: 'Chart 1'),
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
          yValueMapper: (SalesData sales, _) => sales.sales,
          onRendererCreated: (ChartSeriesController controller) {
            _firstChartController = controller;
          },
        ),
      ],
    );
  }
}

class SecondChart extends StatefulWidget {
  const SecondChart({super.key});

  @override
  State<StatefulWidget> createState() {
    return SecondChartState();
  }
}

class SecondChartState extends State<SecondChart> {
  // Declaring a field to check whether the user is interacting with the chart.
  bool _isInteractive = false;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      // Set to false when user touched the chart and hidden the visible Trackball.
      onChartTouchInteractionDown: (ChartTouchInteractionArgs tapArgs) {
        _isInteractive = true;
      },
      // Set to false when user touched the chart and hidden the visible Trackball.
      onChartTouchInteractionUp: (ChartTouchInteractionArgs tapArgs) {
        _isInteractive = false;
        trackBall1.hide();
      },
      // Displayed the trackball when tap on the chart.
      onTrackballPositionChanging: (TrackballArgs trackballArgs) {
        if (_isInteractive) {
          _firstPosition = _firstChartController!.pointToPixel(
            trackballArgs.chartPointInfo.chartPoint!,
          );
          trackBall1.show(_firstPosition!.dx, _firstPosition!.dy, 'pixel');
        }
      },
      backgroundColor: Colors.white,
      primaryXAxis: const CategoryAxis(),
      title: const ChartTitle(text: 'Chart 2'),
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
          yValueMapper: (SalesData sales, _) => sales.sales,
          onRendererCreated: (ChartSeriesController controller) {
            _secondChartController = controller;
          },
        ),
      ],
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
