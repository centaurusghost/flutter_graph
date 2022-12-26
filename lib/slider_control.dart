import 'package:flutter/material.dart';
import 'graph_plot.dart';

class Sliders extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SlidersState();
  }
}

class SlidersState extends State<Sliders> {
  double initialSliderX = 0.0;
  double initialSliderY = 0.0;
  int roundIntX = 0;
  int roundIntY = 0;
  Color buttonColor = Color.fromARGB(255, 1, 17, 97);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "X:$roundIntX",
              style: TextStyle(
                fontSize: 20,
                color: buttonColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Slider(
          value: initialSliderX,
          onChanged: ((value) {
            setState(() {
              initialSliderX = value;
            });
            //print(roundIntX);
            roundIntX = (initialSliderX * 100).toInt();
            //print(roundIntX);
          }),
          inactiveColor: Color.fromARGB(255, 8, 26, 114),
          activeColor: Color.fromARGB(255, 1, 21, 120),
        ),
        Row(
          children: [
            Text(
              "Y:$roundIntY",
              style: TextStyle(
                fontSize: 20,
                color: buttonColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Slider(
          value: initialSliderY,
          onChanged: ((value) {
            setState(() {
              initialSliderY = value;
            });
            //print(roundIntX);
            roundIntY = (initialSliderY * 100).toInt();
            //print(roundIntY);
          }),
          inactiveColor: Color.fromARGB(255, 8, 26, 114),
          activeColor: Color.fromARGB(255, 1, 21, 120),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              //updateGraph.addCoordinates(roundIntX, roundIntY);
            });
            //print("CLick Pressed");
          },
          child: Icon(Icons.check),
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
              buttonColor,
            ),
          ),
        )
      ],
    );
  }
}
