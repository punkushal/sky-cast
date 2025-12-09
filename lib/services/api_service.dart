import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:skycast/models/weather_model.dart';

class ApiService {
  // base url for current weather api
  final _currentWeatherBaseUrl =
      "https://api.openweathermap.org/data/2.5/weather";
  final key = dotenv.get("API_KEY");

  // base url for hourly forecast
  final _hourlyBaseUrl =
      "https://pro.openweathermap.org/data/2.5/forecast/hourly";
  Future<CurrentWeather> fetchCurrentWeather({required String cityName}) async {
    try {
      final url = Uri.parse("$_currentWeatherBaseUrl?q=$cityName&appid=$key");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body); //
        return CurrentWeather.fromJson(jsonData);
      } else {
        throw Exception('Failed to fetch data : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occured while fetching current weather data : $e');
    }
  }

  // hourly forecast
  Future<List<ListElement>> fetchHourlyForecast({int count = 8}) async {
    try {
      final url = Uri.parse("$_hourlyBaseUrl?q=butwal&cnt=$count&appid=$key");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body); //

        final data = Hourlyforecast.fromJson(jsonData);

        return data.list;
      } else {
        throw Exception('Failed to fetch hourly data : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occured while fetching hourly forecast : $e');
    }
  }
}
