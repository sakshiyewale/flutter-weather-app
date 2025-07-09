import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = '6052df0e52064979a81ee91fb04efef1'; // Replace with your actual key

  Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather');
    }
  }
  Future<Map<String, dynamic>> fetchWeatherByCity(String city) async {
    final url =
    'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric';

    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }
  Future<List<Map<String, dynamic>>> fetchForecastByCity(String city) async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$_apiKey&units=metric'),
    );
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['list']);
  }
}
