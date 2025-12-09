import 'package:flutter/material.dart';
import 'package:skycast/models/weather_model.dart';
import 'package:skycast/services/api_service.dart';

class WeatherProvider extends ChangeNotifier {
  // private variables
  final _apiService = ApiService();
  CurrentWeather? _currentWeather;
  List<ListElement> _hourleyForecastDataList = [];
  bool _isLoading = false;
  String _errorMessage = "";
  double _loadingProgress = 0.0;

  // getter functions to access value stored by private variables
  CurrentWeather? get currentWeather => _currentWeather;
  List<ListElement> get hourlyDataList => _hourleyForecastDataList;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  double get loadingProgress => _loadingProgress;

  // methods to communicate with api service class
  Future<void> fetchCurrentWeather({required String cityName}) async {
    _isLoading = true;
    _errorMessage = "";
    _loadingProgress = 0.0;
    notifyListeners();
    try {
      // 33 % complete
      _loadingProgress = 0.33;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 500));

      // 66% completed
      _loadingProgress = 0.66;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 500));
      _currentWeather = await _apiService.fetchCurrentWeather(
        cityName: cityName,
      );

      // 100% completed
      _loadingProgress = 1;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchHourlyForecast() async {
    _isLoading = true;
    _errorMessage = "";
    _loadingProgress = 0.0;
    notifyListeners();
    try {
      _hourleyForecastDataList = await _apiService.fetchHourlyForecast();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
