import 'dart:ui';
import 'package:flutter_graph/gradient_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineTitles {
  final Map<int, String> map = {};
  void generateMap() {
    for (int i = 0; i <= 200; i++) {
      map[i] = i.toString();
    }
   // print(map);
  }

  LineTitles(this.graphTitle);

  var graphTitle = "";

  static const defaultStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15.0,
    color: Colors.yellow,
  );
  static const defaultLargeStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    color: Colors.white,
  );
  FlTitlesData getTitleData() {
    generateMap();
    return FlTitlesData(
      show: true,
      bottomTitles: mainData(),
      rightTitles: mainData(),
      leftTitles: mainData(),
      topTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: false,
        getTitlesWidget: (value, meta) {
          switch (value.toInt()) {
            // case 40: return const Text("");
            case 5:
              return const Text(
                "HeartBeat",
                style: defaultLargeStyle,
              );
            // case 55:  return const Text("55");

          }

          return const Text("");
        },
      )),
      //  / leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  AxisTitles mainData() {
    return AxisTitles(
        sideTitles: SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        if (value != 30) {
          final String text = map[value.toInt()] ?? "";
          return newGradientText(text);
        }

         return const Text("");
      },
    ));
  }
  GradientText newGradientText(String text){
    return GradientText(
                text,
                style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 221, 255, 0),
                  Color.fromARGB(255, 255, 4, 4),
                  
                  // Color.fromARGB(255, 217, 255, 0),
                  // Color.fromARGB(255, 4, 255, 0),
                  // Colors.indigo,
                  // Color.fromARGB(255, 224, 4, 248),
                ]),
              );
  }
}
