import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather/Weather/OpenWeather.dart';
import 'package:weather/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final openWeather = const OpenWeather(weather_api_key);

  void initState() {
    var res = openWeather.getWeatherDetails(37.7749, -122.4194);
    res
        .then((value) => print('Weather details: $value'))
        .catchError((e) => print('Error: $e'));
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: openWeather.getWeatherDetails(37.7749, -122.4194),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();
              else if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');

              var data = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("City: ${data!['name']}"),
                  Text("Lat: ${data!['coord']['lat']}"),
                  Text("Lon: ${data!['coord']['lon']}"),
                  Text("Weather: ${data!['weather'][0]['description']}"),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
