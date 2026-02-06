import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:weather/Weather/OpenWeather.dart';
import 'package:weather/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final openWeather = const OpenWeather(weather_api_key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: openWeather.getWeatherDetails(6.9271, 79.8612),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();
              else if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');

              var data = snapshot.data;
              if (data == null) {
                return Text("no data found");
              }
              return Column(
                children: [
                  SizedBox(height: 2),
                  Image.network(
                    openWeather.getWeatherIcon(data['weather'][0]['icon']),
                    width: 150,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['main']['temp'].toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("°C"),
                    ],
                  ),

                  SizedBox(height: 10),
                  // Text("City: ${data['name']}"),
                  // Text("Lat: ${data['coord']['lat']}"),
                  // Text("Lon: ${data['coord']['lon']}"),
                  // Text("Weather: ${data['weather'][0]['description']}"),
                  Text(data['name']),
                  SizedBox(height: 80),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      Icon(MdiIcons.thermometerLow),
                      Column(
                        children: [
                          Text("Min"),
                          Text('${data['main']['temp_min']} °C'),
                        ],
                      ),

                      SizedBox(width: 20),
                      Icon(MdiIcons.thermometerHigh),
                      Column(
                        children: [
                          Text("Max"),
                          Text('${data['main']['temp_max']} °C'),
                        ],
                      ),

                      SizedBox(width: 20),
                      Icon(MdiIcons.water),
                      Column(
                        children: [
                          Text("Humadity"),
                          Text('${data['main']['humidity']} %'),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
