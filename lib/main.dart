import 'package:flutter/material.dart';
import 'package:my_appe/screens/iotscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/iotscreen': (BuildContext context) => IotScreen(),
      },
      debugShowCheckedModeBanner: true,
      home: IotScreen(),
    );
  }
}
