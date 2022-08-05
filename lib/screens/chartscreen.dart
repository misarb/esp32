// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:oscilloscope/oscilloscope.dart';

import '../widgets/iotWedgets.dart';
import 'iotscreen.dart';

class ChartScreen extends StatefulWidget {
  @override
  State<ChartScreen> createState() => _ChartScreen();
}

class _ChartScreen extends State<ChartScreen> {
  List<double> traceData = [];
  Timer? _timer;
  double getData = 0.0;

  final dbRef = FirebaseDatabase.instance.ref();
  _generateTrace(Timer t) {
    setState(() {
      traceData.add(getData);
    });
  }

  @override
  initState() {
    super.initState();
    // create our timer to generate test values
    _timer = Timer.periodic(Duration(milliseconds: 500), _generateTrace);
  }

  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else {
      return value.toDouble();
    }
  }

  Widget build(BuildContext context) {
    Oscilloscope scopeOne = Oscilloscope(
      showYAxis: true,
      yAxisColor: Colors.white,
      margin: EdgeInsets.all(20.0),
      strokeWidth: 2.0,
      backgroundColor: Colors.black,
      traceColor: Colors.green,
      yAxisMax: 50.0,
      yAxisMin: -100.0,
      dataSet: traceData,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Chart your Data',
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
            getData = checkDouble(values["Temperateur"].toString());

            return Column(
              children: [
                WidgetData(title: "Distance Chart"),
                Expanded(flex: 1, child: scopeOne),
                WidgetData(title: "Temp Chart"),
                Expanded(flex: 1, child: scopeOne),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
