// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_appe/screens/chartscreen.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class IotScreen extends StatefulWidget {
  @override
  State<IotScreen> createState() => _IotScreenState();
}

class _IotScreenState extends State<IotScreen> {
  @override
  bool value = false;
  double _sliderIncrement = 20.0;

  final dbRef = FirebaseDatabase.instance.ref();

  servoControler(value) {
    setState(() {
      _sliderIncrement = value;
    });
  }

  buttonUpdate() {
    setState(() {
      value = !value;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'ESP32 WITH FIREBASE',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: StreamBuilder(
        stream: dbRef.child("Data").onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              !snapshot.hasError &&
              snapshot.data!.snapshot.value != null) {
            Map<dynamic, dynamic> values =
                snapshot.data?.snapshot.value as Map<dynamic, dynamic>;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "Configurations",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.settings)
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        WidgetData(
                          title: "Temperateur",
                        ),
                        WidgetData(
                          title: values["Temperateur"].toString(),
                        ),
                        SizedBox(height: 20.0),
                        WidgetData(
                          title: "Motor Vitess",
                        ),
                        WidgetData(
                          title: values["vitesse"].toString(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        FloatingActionButton.extended(
                          //focusColor: Colors.yellow,
                          backgroundColor: value ? Colors.green : Colors.red,
                          onPressed: () {
                            buttonUpdate();
                            writeIntoFirebase();
                          },
                          label: value ? Text("ON") : Text("OFF"),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        WidgetData(title: "Controle Servo Motor"),
                        Slider(
                          value: _sliderIncrement,
                          min: 0,
                          max: 180,
                          divisions: 10,
                          thumbColor: Colors.red,
                          activeColor: Colors.purple,
                          inactiveColor: Colors.redAccent,
                          label: _sliderIncrement.round().toString(),
                          onChanged: (value) {
                            servoControler(value);
                            writeIntoFirebase();
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SleekCircularSlider(
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
                                bottomLabelStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                                bottomLabelText: 'Temp.',
                                mainLabelStyle: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600),
                                modifier: (double value) {
                                  return '$_sliderIncrement ??C ';
                                }),
                            startAngle: 90,
                            angleRange: 360,
                            size: 180.0,
                            animationEnabled: true,
                          ),
                          min: 0,
                          max: 180,
                          initialValue: _sliderIncrement,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        FloatingActionButton.extended(
                            label: Text("Chart"),
                            backgroundColor: Colors.blueAccent,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChartScreen()),
                              );
                            }),
                      ],
                    )
                  ],
                )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Future<void> writeIntoFirebase() async {
    dbRef.child("Data").set({
      "Temperateur": 0,
      "vitesse": 120,
      //"controler": _sliderIncrement,
    });
    dbRef.child("LightState").set({
      "switch": !value,
    });
    dbRef.child("MotorServer").set({
      "controler": _sliderIncrement,
    });
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
        padding: EdgeInsets.all(8.0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
