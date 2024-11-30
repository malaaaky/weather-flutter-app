import 'package:flutter/material.dart';
import 'screens/HomeScreen.dart';
import 'screens/CurrentWeatherScreen.dart';
import 'screens/ForecastScreen.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/currentWeather': (context) => CurrentWeatherScreen(),
        '/forecast': (context) => ForecastScreen(),
      },
    );
  }
}
