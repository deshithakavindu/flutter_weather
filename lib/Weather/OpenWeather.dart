import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenWeather {
  final String apiKey;

  OpenWeather(this.apiKey);

  Future<Map<String, dynamic>> getWeatherDetails(double lat, double lon) async {
    final Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather'
      '?lat=$lat&lon=$lon&appid=$apiKey&units=metric',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data; // return weather data
      } else {
        throw Exception('Failed to load weather: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }
}
