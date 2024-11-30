import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForecastScreen extends StatefulWidget {
  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  List<dynamic> forecastData = [];

  Future<void> fetchForecast(String city) async {
    final url ='https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=4f2d9c7e7f9060cdc29d76a764432a5d&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        forecastData = data['list'].take(3).toList();
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String city = ModalRoute.of(context)?.settings.arguments as String? ?? 'London';
    fetchForecast(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('3-Day Forecast')),
      body: forecastData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: forecastData.length,
        itemBuilder: (context, index) {
          final forecast = forecastData[index];
          return Card(
            child: ListTile(
              title: Text('${forecast['dt_txt']}'),
              subtitle: Text(
                  '${forecast['main']['temp']}°C - ${forecast['weather'][0]['description']}'),
            ),
          );
        },
      ),
    );
  }
}
