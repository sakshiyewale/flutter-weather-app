import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../services/whetherservices.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  final WeatherService _weatherService = WeatherService();
  String city = "Fetching...";
  String temperature = "";
  String condition = "";
  String humidity = "";
  String windSpeed = "";
  List<Map<String, dynamic>> forecastList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchWeatherByLocation();
  }

  Future<void> _fetchWeatherByLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final data = await _weatherService.fetchWeather(
        position.latitude,
        position.longitude,
      );
      final forecast = await _weatherService.fetchForecastByCity(data['name']);
      _updateWeatherData(data, forecast);
    } catch (e) {
      setState(() {
        city = "Error fetching data";
      });
    }
  }

  Future<void> _fetchWeatherByCity(String cityName) async {
    try {
      final data = await _weatherService.fetchWeatherByCity(cityName);
      final forecast = await _weatherService.fetchForecastByCity(cityName);
      _updateWeatherData(data, forecast);
    } catch (e) {
      setState(() {
        city = "City not found!";
      });
    }
  }

  void _updateWeatherData(Map<String, dynamic> data, List<Map<String, dynamic>> forecast) {
    setState(() {
      city = data['name'] ?? 'Unknown';
      temperature = "${data['main']['temp']}°C";
      condition = data['weather'][0]['description'];
      humidity = "${data['main']['humidity']}%";
      windSpeed = "${data['wind']['speed']} m/s";
      forecastList = forecast;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/image1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _buildSearchBar(),
            SizedBox(height: 2.h),
            _buildWeatherInfo(),
            SizedBox(height: 3.h),
            _buildForecastList()
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Search city...",
              hintStyle: TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.black38,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) _fetchWeatherByCity(value);
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {
            if (_searchController.text.isNotEmpty) {
              _fetchWeatherByCity(_searchController.text);
            }
          },
        )
      ],
    );
  }

  Widget _buildWeatherInfo() {
    return Container(
      height: 40.h,
      width: 80.w,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Column(
        children: [
          Text(
            city,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("Temperature: $temperature", style: _textStyle()),
          Text("Condition: $condition", style: _textStyle()),
          Text("Humidity: $humidity", style: _textStyle()),
          Text("Wind: $windSpeed", style: _textStyle()),
        ],
      ),
    );
  }

  Widget _buildForecastList() {
    return forecastList.isEmpty
        ? const CircularProgressIndicator()
        : SizedBox(
      height: 20.h, // Set a fixed height for horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecastList.length,
        itemBuilder: (context, index) {
          final forecast = forecastList[index];
          final dateTime = DateFormat('dd MMM, hh:mm a')
              .format(DateTime.parse(forecast['dt_txt']));
          final temp = forecast['main']['temp'].toStringAsFixed(1);
          final desc = forecast['weather'][0]['description'];

          return Container(
            width: 40.w,
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dateTime,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
                SizedBox(height: 1.h),
                Text(
                  "$temp°C",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
    );
  }
}
