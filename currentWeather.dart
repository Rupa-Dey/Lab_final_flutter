import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/data_table.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/models/Weather.dart';

import 'package:http/http.dart' as http;

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                currentWeatherPage(),
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

         body: Container(

          alignment: Alignment.center,
           color: Colors.grey,
           child:Text("skip>>",


             style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),
           ),
         ),
    );
  }
}


class currentWeatherPage extends StatefulWidget {
  const currentWeatherPage({Key? key}) : super(key: key);

  @override
  State<currentWeatherPage> createState() => _currentWeatherPageState();
}

class _currentWeatherPageState extends State<currentWeatherPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color.fromARGB(212, 1, 45, 56),


      body:

      Center(

        child: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot != null) {
              print(snapshot);
              Weather _weather = snapshot.data;
              print("today's weather is : ${_weather}");
              if (_weather == null) {
                return Text("Error getting weather");
              } else {
                return weatherBox(_weather);
              }
            } else {
              return CircularProgressIndicator();
            }
          },
          future: getCurrentWeather(),
        ),
       ),

    );
  }
}





Widget weatherBox(Weather _weather) {

  DateTime dt = DateTime.now();
  return Column(mainAxisSize: MainAxisSize.min,

    children: <Widget>[

       Text("Current time : ${dt}", style: TextStyle(fontSize: 15.0),),
      Icon(Icons.cloud_circle,size: 50.0,),
      Container(  //borderside.top dite hoto..

        decoration: BoxDecoration(  //,
          border: Border(bottom: BorderSide(width: 2.0)),
        //borderRadius: BorderRadius.circular(5.0),
      ),
        padding: EdgeInsets.all(10.0),
       margin: EdgeInsets.fromLTRB(2,2,2,20),

       child: Text("View Weather",
          style: TextStyle(
          fontSize: 25,color: Color.fromARGB(255, 201, 5, 5),

          ),


       )
      ),
      Container(
        margin: const EdgeInsets.all(10.0),
        child: Text("${_weather.temp}°C        ${_weather.faren}° F",
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
        ),
      ),

      Text(" Feels: ${_weather.feelslike}°C",
      style: TextStyle(fontSize: 18),
  ),
      Text("High: ${_weather.high}°C   Low: ${_weather.low}°C",


        style: TextStyle(fontSize: 18),),
     
       DataTable(columns: [
         DataColumn(label: Text("ForecastType ")),
         DataColumn(label: Text("Result ")),
       ], rows: [
         DataRow(cells: [
           DataCell(Text("আর্দ্রতা:  ",style: TextStyle(fontSize: 18))),
          DataCell(Text("${_weather.humidity} %",
       style: TextStyle(fontSize: 20),),),


       ]),

  DataRow(cells: [
  DataCell(Text("বায়ুচাপ:  ",style: TextStyle(fontSize: 18))),
  DataCell(Text("${_weather.pressure} mBar",
  style: TextStyle(fontSize: 20),),),


  ]),
  DataRow(cells: [
  DataCell(Text("বাতাসের গতি: ",style: TextStyle(fontSize: 18),)),
  DataCell(Text("${_weather.speed} mph",
    style: TextStyle(fontSize: 20),),),
  ]),
     ]),

      Container(
        child:
        Text("${_weather.description}",
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
        ),)
    ],
  );
}

Future getCurrentWeather() async {
  late Weather weather;
  var url =
      "https://api.openweathermap.org/data/2.5/weather?q=Rajshahi&appid=db7e8f8d800906537acc20b8ec2168d7&units=metric";
  final response = await http.get(url);
  print(response.body);
  if (response.statusCode == 200) {
    // print(response.body);
    weather = Weather.fromJson(jsonDecode(response.body));
  }
  return weather;
}
