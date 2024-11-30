import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrentWeatherScreen extends StatefulWidget {
  @override
  _CurrentWeatherScreenState createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
  Map<String, dynamic>? weatherData;
  Future<void> fetchCurrentWeather(String city) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=4f2d9c7e7f9060cdc29d76a764432a5d';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // final city = ModalRoute.of(context)!.settings.arguments as String;
    String city = ModalRoute.of(context)?.settings.arguments as String? ?? 'London';
    fetchCurrentWeather(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Current Weather')),
      body: weatherData == null
          ? Center(child: CircularProgressIndicator())
          : Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_getBackgroundImage(weatherData!['weather'][0]['main'])),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${weatherData!['name']} - ${_kelvinToCelsius(weatherData!['main']['temp'])}°C',
                style: TextStyle(fontSize: 32, color: Colors.black),
              ),
              Text(
                '${weatherData!['weather'][0]['main']}',
                style: TextStyle(fontSize: 24, color: Colors.black54),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Back'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  String city = weatherData!['name']; // Get the current city name
                  Navigator.pushNamed(context, '/forecast', arguments: city); // Navigate to forecast page
                },
                child: Text('View 3-Day Forecast'),
              ),
                ],
          ),
        ),
      ),
    );
  }

  // Function to convert Kelvin to Celsius
  String _kelvinToCelsius(double kelvin) {
    double celsius = kelvin - 273.15;
    return celsius.toStringAsFixed(1); // Return temperature with one decimal point
  }

  String _getBackgroundImage(String weatherCondition) {
    switch (weatherCondition.toLowerCase()) {
      case 'clouds':
        // return 'lib/assets/cloudy.jpeg';
        return '/Users/rada/StudioProjects/weather/lib/assets/cloudy.jpeg';
      case 'rain':
        return '/Users/rada/StudioProjects/weather/lib/assets/rainy.jpg';
      case 'clear':
        return '/Users/rada/StudioProjects/weather/lib/assets/sunny.png';
      default:
        return '/Users/rada/StudioProjects/weather/lib/assets/default.png';
    }
  }
}
//
//
// @override
// Widget build(BuildContext context) {
//   String city = ModalRoute.of(context)?.settings.arguments as String? ?? 'London';
//
//   return Scaffold(
//     appBar: AppBar(title: Text('Current Weather')),
//     body: FutureBuilder<Map<String, dynamic>>(
//       future: fetchCurrentWeather(city), // Assuming this returns a Future<Map<String, dynamic>>
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           final weatherData = snapshot.data!;
//           // Your existing code to build the UI with weatherData
//         }
//       },
//     ),
//   );
// }
//
// // Update your fetchCurrentWeather to return a Future
// Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
//   final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=YOUR_API_KEY';
//   final response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200) {
//     return json.decode(response.body);
//   } else {
//     throw Exception('Failed to load weather data');
//   }
// }
