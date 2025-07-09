import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final TextEditingController _controller = TextEditingController();
  String city = "";
  String temperature = "";
  String description = "";
  String iconCode = "";

  final String apiKey = '6052df0e52064979a81ee91fb04efef1';

  Future<void> fetchWeather(String cityName) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        city = data['name'];
        temperature = data['main']['temp'].toString();
        description = data['weather'][0]['description'];
        iconCode = data['weather'][0]['icon'];
      });
    } else {
      setState(() {
        city = "City not found";
        temperature = "";
        description = "";
        iconCode = "";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade300, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter City Name',
                    prefixIcon: Icon(Icons.location_city),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    fetchWeather(_controller.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Get Weather", style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 30),
                if (city.isNotEmpty)
                  Container(
                    height: 40.h,
                    width: 80.w,
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.white.withOpacity(0.9),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              city,
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "$temperature°C",
                              style: TextStyle(fontSize: 24, color: Colors.blueGrey),
                            ),
                            SizedBox(height: 8),
                            Text(
                              description,
                              style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 12),
                            if (iconCode.isNotEmpty)
                              Image.network(
                                'https://openweathermap.org/img/wn/$iconCode@2x.png',
                                height: 100,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
