

import 'package:flutter/material.dart';
import 'package:weather_app/currentWeather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: const Color(0xd3e7e7f1),
          displayColor: const Color(0xfff3f3f6),
        ),

      ),

      home: const splashScreen(),    //currentWeatherPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
