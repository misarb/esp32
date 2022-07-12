// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class IotScreen extends StatefulWidget {
  @override
  State<IotScreen> createState() => _IotScreenState();
}

class _IotScreenState extends State<IotScreen> {
  @override
  bool value = false;
  buttonUpdate() {
    setState(() {
      value = !value;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Icon(
                  Icons.clear_all,
                ),
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
                  Padding(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        "Temperateur",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "20.0",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  SizedBox(height: 20.0),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Motor Vitess",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        "120",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  FloatingActionButton.extended(
                    //focusColor: Colors.yellow,
                    backgroundColor: value ? Colors.green : Colors.red,
                    onPressed: () {
                      buttonUpdate();
                    },
                    label: value ? Text("ON") : Text("OFF"),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
