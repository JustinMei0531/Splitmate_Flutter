import "package:flutter/material.dart";
import "package:syncfusion_flutter_charts/charts.dart";
import "dart:math"; // To generate random values

class UserActivityDetail extends StatelessWidget {
  UserActivityDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: 300.0,
        child: SfCartesianChart(
          primaryXAxis: DateTimeAxis(), // X-axis with DateTime format
          series: <LineSeries<ServiceData, DateTime>>[
            LineSeries<ServiceData, DateTime>(
              name: 'Power',
              dataSource: powerData,
              xValueMapper: (ServiceData service, _) => service.date,
              yValueMapper: (ServiceData service, _) => service.fee,
            ),
            LineSeries<ServiceData, DateTime>(
              name: 'Water',
              dataSource: waterData,
              xValueMapper: (ServiceData service, _) => service.date,
              yValueMapper: (ServiceData service, _) => service.fee,
            ),
            LineSeries<ServiceData, DateTime>(
              name: 'Gas',
              dataSource: gasData,
              xValueMapper: (ServiceData service, _) => service.date,
              yValueMapper: (ServiceData service, _) => service.fee,
            ),
            LineSeries<ServiceData, DateTime>(
              name: 'Internet',
              dataSource: internetData,
              xValueMapper: (ServiceData service, _) => service.date,
              yValueMapper: (ServiceData service, _) => service.fee,
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceData {
  ServiceData(this.date, this.fee);
  final DateTime date;
  final double fee;
}

// Function to generate random data for services over the last 30 days
List<ServiceData> generateRandomData(String serviceName) {
  List<ServiceData> serviceData = [];
  Random random = Random();
  DateTime today = DateTime.now();

  for (int i = 0; i < 30; i++) {
    DateTime date = today.subtract(Duration(days: i));
    double fee =
        100 + random.nextDouble() * 100; // Random fee between 100 and 200
    serviceData.add(ServiceData(date, fee));
  }
  return serviceData;
}

// Generating random data for each service
final List<ServiceData> powerData = generateRandomData('Power');
final List<ServiceData> waterData = generateRandomData('Water');
final List<ServiceData> gasData = generateRandomData('Gas');
final List<ServiceData> internetData = generateRandomData('Internet');
