import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_appe/screens/chartscreen.dart';

import '../widgets/iotWedgets.dart';

class IotScreen extends StatefulWidget {
  @override
  State<IotScreen> createState() => _IotScreenState();
}

class _IotScreenState extends State<IotScreen> {
  @override
  bool value = false;
  double _sliderIncrement = 0.0;

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

  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else {
      return value.toDouble();
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'IOT APP with ESP32 and FIREBASE',
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
              double temp = checkDouble(values["Temperateur"].toString());
              return Column(
                children: [
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          WidgetData(
                            title: "Temperateur",
                          ),
                          CircleWidgetData(
                            temp: temp,
                            charText: "˚C",
                          ),
                          const SizedBox(height: 20.0),
                          WidgetData(
                            title: "stepper Motor speed",
                          ),
                          CircleWidgetData(
                            temp: temp,
                            charText: "rpms",
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          FloatingActionButton.extended(
                            icon: value
                                ? const Icon(
                                    Icons.light_mode,
                                  )
                                : const Icon(
                                    Icons.light_mode_outlined,
                                  ),
                            backgroundColor: value ? Colors.green : Colors.red,
                            onPressed: () {
                              buttonUpdate();
                              writeIntoFirebase();
                            },
                            label: value ? const Text("ON") : const Text("OFF"),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          WidgetData(title: "ServoMotor Controller"),
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
                          const SizedBox(
                            height: 10.0,
                          ),
                          FloatingActionButton.extended(
                              label: const Text("Go to Chart"),
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
      ),
    );
  }

  Future<void> writeIntoFirebase() async {
    dbRef.child("LightState").set({
      "switch": !value,
    });
    dbRef.child("MotorServer").set({
      "controler": _sliderIncrement,
    });
  }
}
