import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_appe/screens/chartscreen.dart';
import 'package:my_appe/screens/iotscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/iotscreen': (BuildContext context) => IotScreen(),
        '/chartscreen': (BuildContext context) => ChartScreen(),
      },
      // theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: true,
      home: IotScreen(),
    );
  }
}
