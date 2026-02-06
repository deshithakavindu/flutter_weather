import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class OpenWeather {
  final String apiKey;
  const OpenWeather(this.apiKey);

  Future<Map> getWeatherDetails(double lat, double lon) async {
    print('Getting weather details for lat: $lat, lon: $lon');

    var url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?units=metric&lat=$lat&lon=$lon&appid=$apiKey',
    );
    print('Requesting URL: $url');

    try {
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Responses body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      rethrow;
    }
  }

  String getWeatherIcon(String icon) {
    return "https://openweathermap.org/img/wn/$icon@2x.png";
  }
}
