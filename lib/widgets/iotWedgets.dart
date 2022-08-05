import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter/material.dart';

class CircleWidgetData extends StatelessWidget {
  const CircleWidgetData({
    Key? key,
    required this.temp,
    required this.charText,
  }) : super(key: key);

  final double temp;
  //final String text_title;
  final String charText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SleekCircularSlider(
        appearance: CircularSliderAppearance(
          customWidths: CustomSliderWidths(
            trackWidth: 3,
            progressBarWidth: 15,
            shadowWidth: 30,
          ),
          customColors: CustomSliderColors(
              shadowMaxOpacity: 0.5, //);
              shadowStep: 20),
          infoProperties: InfoProperties(
              bottomLabelStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              //bottomLabelText: text_title,
              mainLabelStyle:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              modifier: (double value) {
                return '$temp  $charText';
              }),
          startAngle: 90,
          angleRange: 360,
          size: 150.0,
          animationEnabled: true,
        ),
        min: 0,
        max: 180,
        initialValue: temp,
      ),
    );
  }
}

class WidgetData extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  WidgetData({
    required this.title,
  });
  String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: const TextStyle(
            //color: Colors.lightBlue,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
