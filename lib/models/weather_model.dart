// weather model for current data
class CurrentWeather {
  List<Weather> weather;
  Main main;
  int visibility;
  Wind wind;
  Sys sys;
  String name;

  CurrentWeather({
    required this.weather,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.sys,
    required this.name,
  });

  // convert json to dart object
  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      weather: (json['weather'] as List)
          .map((item) => Weather.fromJson(item))
          .toList(),
      main: Main.fromJson(json['main']), // 'main'
      visibility: json['visibility'],
      wind: Wind.fromJson(json['wind']),
      sys: Sys.fromJson(json['sys']),
      name: json['name'],
    );
  }
}

class Main {
  double temp;
  double feelsLike;
  int pressure;
  int humidity;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
    );
  }
}

class Sys {
  String country;
  int sunrise;
  int sunset;

  Sys({required this.country, required this.sunrise, required this.sunset});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}

class Weather {
  String main;
  String description;

  Weather({required this.main, required this.description});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      main: json['main'] ?? 'no main',
      description: json['description'] ?? 'no description',
    );
  }
}

class Wind {
  double speed;

  Wind({required this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(speed: (json['speed'] as num).toDouble());
  }
}

// hourly forecast model
class Hourlyforecast {
  List<ListElement> list;

  Hourlyforecast({required this.list});

  factory Hourlyforecast.fromJson(Map<String, dynamic> json) {
    return Hourlyforecast(
      list: (json['list'] as List)
          .map((item) => ListElement.fromJson(item))
          .toList(),
    );
  }
}

class ListElement {
  Main main;
  List<Weather> weather;
  Wind wind;
  int visibility;

  // forecasted date time
  String dtTxt;

  ListElement({
    required this.main,
    required this.weather,
    required this.wind,
    required this.visibility,
    required this.dtTxt,
  });

  // convert json to dart object
  factory ListElement.fromJson(Map<String, dynamic> json) {
    return ListElement(
      main: Main.fromJson(json['main']),
      weather: (json['weather'] as List)
          .map((item) => Weather.fromJson(item))
          .toList(),
      wind: Wind.fromJson(json['wind']),
      visibility: json['visibility'] ?? 0,
      dtTxt: json['dt_txt'] ?? "no data available",
    );
  }
}
