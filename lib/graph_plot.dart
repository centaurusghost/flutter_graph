import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'line_titles.dart';
import 'gradient_text.dart';
import 'dart:async';
//import 'slider_control.dart';
import 'dart:math';

class GraphPlot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GraphPlotState();
  }
}

class GraphPlotState extends State<GraphPlot> {
  static const defaultStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15.0,
    color: Colors.yellow,
  );
  static const defaultLargeStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    color: Colors.yellow,
  );
  var timer;
  int xCoord = 0;
  int yCoord = 0;
  double initialSliderX = 0.0;
  double initialSliderY = 0.0;
  int roundIntX = 0;
  int roundIntY = 0;
  Color buttonColor = Color.fromARGB(255, 1, 17, 97);
  GraphPlotState.setCoordinates(this.xCoord, this.yCoord);
  List<FlSpot> heartSpots = List<FlSpot>.empty(growable: true);
  List<FlSpot> tempSpots = List<FlSpot>.empty(growable: true);
  GraphPlotState();

  LineTitles mainHeartData = LineTitles("");

  LineTitles mainTemperatureData = LineTitles("");
  double heartRate = 68.0;
  double temperature = 37.0;
  List<double> heartY = List.empty(growable: true);
  List<double> tempY = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    //generateCoordinates();
    generateCoordinatesHeart();
    generateCoordinatesTemperature();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //heartRate = heartSpots[9].y;
   // temperature = tempSpots[9].y;
   // print(heartRate);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Health Monitoring System")),
        backgroundColor: Color.fromARGB(255, 1, 17, 97),
      ),
      backgroundColor: Color.fromARGB(255, 1, 14, 71).withOpacity(0.8),
      body: Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
        child: Center(
          child: Column(
            children: [
              // SizedBox(
              //   height: height / 3.5,
              // ),
              // newGradientText("Lets see"),
              ElevatedButton(
                onPressed: (() {
                  // exampleFunction();
                  startUpdatingData();
                }),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 2, 149, 88)),
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Start Tracking"),
                  // Icon(Icons.notification_important),
                ]),
              ),

              Center(
                child: Row(
                  children: [
                    //Padding(padding: EdgeInsets.only(left: width / 3 - 25)),
                    Icon(
                      Icons.monitor_heart_rounded,
                      color: Colors.red,
                    ),
                    Text(
                      " Heart: $heartRate bpm ",
                      style: defaultLargeStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.emoji_emotions,
                      color: Color.fromARGB(255, 255, 145, 0),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.device_thermostat_sharp,
                      color: Color.fromARGB(255, 255, 145, 0),
                    ),
                    Text(
                      " Temp: $temperature °C",
                      style: defaultLargeStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 35,
              ),

              graphingConatiner(mainHeartData, heartSpots, height, width),

              // graphingConatiner(mainTemperatureData, tempSpots, height, width),
            ],
          ),
        ),
      ),
    );
  }

  void generateCoordinatesHeart() {
    for (int i = 0; i < 11; i++) {
      //  print(i.toDouble() + generateRandomHeartBeat().toDouble());
      // heartY[i++] = generateRandomHeartBeat().toDouble();
      heartSpots
          .add(FlSpot(i.toDouble(), generateRandomHeartBeat().toDouble()));
    }
  }

  void generateCoordinatesTemperature() {
    for (int i = 0; i < 11; i++) {
      //  print(i.toDouble() + generateRandomTemperature().toDouble());
      tempSpots
          .add(FlSpot(i.toDouble(), generateRandomTemperature().toDouble()));
    }
  }

  int generateRandomHeartBeat() {
    var random = Random();
    int randomInt = random.nextInt(7) + 62;
    return randomInt;
  }

  int generateRandomTemperature() {
    var random = Random();
    int randomInt = random.nextInt(5) + 45;
    return randomInt;
  }

  void startUpdatingData() {
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      var tempListHeart = List<FlSpot>.empty(growable: true);
      var tempListTemp = List<FlSpot>.empty(growable: true);

//gettng y values from the list FLspot
//now we shall create a new list from his values
//and add a new value at index 10
      int tempI = 0;
      for (int i = 0; i < 10; i++) {
       tempI++;
        tempListHeart.add(FlSpot(i.toDouble(), heartSpots[tempI].y));
        tempListTemp.add(FlSpot(i.toDouble(), tempSpots[tempI].y));
      }
      tempListHeart.add(FlSpot(10, generateRandomHeartBeat().toDouble()));
      tempListTemp.add(FlSpot(10, generateRandomTemperature().toDouble()));
      
      heartSpots = tempListHeart;
      tempSpots = tempListTemp;

      //heartSpots=List<FlSpot>.empty(growable: true);
      // tempSpots=List<FlSpot>.empty(growable: true);
      //generateCoordinatesHeart();
      //generateCoordinatesTemperature();
      // heartSpots.add(FlSpot(10, generateRandomHeartBeat().toDouble()));
      // tempSpots.add(FlSpot(10, generateRandomTemperature().toDouble()));
      // print(tempSpots);
      // heartSpots.removeAt(0);
      // tempSpots.removeAt(0);

      // // Add new data to the lists
      // heartSpots.add(FlSpot(10, generateRandomHeartBeat().toDouble()));
      // tempSpots.add(FlSpot(10, generateRandomHeartBeat().toDouble()));

      // Redraw the graph
      setState(() {});
    });
  }

  //return graphing container
  Container graphingConatiner(
      LineTitles mainData, List<FlSpot> spots, double height, double width) {
    return Container(
      height: height / 2,
      width: width,
      child: LineChart(LineChartData(
        //  / backgroundColor: Colors.amber,
        minX: 0,
        maxX: 10,
        minY: 30,
        maxY: 80,
        titlesData: mainTemperatureData.getTitleData(),

        backgroundColor: Color.fromARGB(255, 1, 17, 97),
        lineBarsData: [
          LineChartBarData(
            color: Colors.red,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.amber,
                Colors.red,
                Color.fromARGB(255, 238, 15, 175)
              ],
            ),
            spots: heartSpots,
            isCurved: true,
            dotData: FlDotData(
              show: false,
            ),
            barWidth: 2,
            // dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
            ),
          ),
          LineChartBarData(
            color: Colors.red,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.amber,
                Colors.red,
                Color.fromARGB(255, 238, 15, 175)
              ],
            ),
            spots: tempSpots,
            isCurved: true,
            dotData: FlDotData(
              show: false,
            ),
            barWidth: 2,
            // dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
            ),
          ),
        ],
      )),
    );
  }

  GradientText newGradientText(String text) {
    return GradientText(
      text,
      style: const TextStyle(fontSize: 40),
      gradient: LinearGradient(colors: [
        Color.fromARGB(255, 255, 4, 4),
        Color.fromARGB(255, 255, 153, 0),
        Color.fromARGB(255, 217, 255, 0),
        Color.fromARGB(255, 4, 255, 0),
        Colors.indigo,
        Color.fromARGB(255, 224, 4, 248),
      ]),
    );
  }
}
