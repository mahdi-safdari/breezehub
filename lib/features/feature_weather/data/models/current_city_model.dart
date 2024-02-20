import 'package:breezehub/features/feature_weather/domain/entities/current_city_entity.dart';

class CurrentCityModel extends CurrentCityEntity {
  const CurrentCityModel({
    super.coord,
    super.weather,
    super.base,
    super.main,
    super.visibility,
    super.wind,
    super.clouds,
    super.dt,
    super.sys,
    super.id,
    super.name,
    super.cod,
    super.timezone,
  });

  factory CurrentCityModel.fromJson(Map<String, dynamic> json) {
    List<Weather> weather = [];
    if (json['weather'] != null) {
      json['weather'].forEach((v) {
        weather.add(Weather.fromJson(v));
      });
    }

    return CurrentCityModel(
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      weather: weather,
      base: json['base'],
      main: json['main'] != null ? Main.fromJson(json['main']) : null,
      visibility: json['visibility'],
      wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
      clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null,
      dt: json['dt'],
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
      timezone: json['timezone'],
    );
  }
}

class Sys {
  num? type;
  num? id;
  num? message;
  String? country;
  num? sunrise;
  num? sunset;

  Sys({this.type, this.id, this.message, this.country, this.sunrise, this.sunset});

  Sys.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    message = json['message'];
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
}

class Clouds {
  num? all;
  Clouds({this.all});

  Clouds.fromJson(dynamic json) {
    all = json['all'];
  }
}

class Wind {
  num? speed;
  num? deg;

  Wind({this.speed, this.deg});

  Wind.fromJson(dynamic json) {
    speed = json['speed'];
    deg = json['deg'];
  }
}

class Main {
  num? temp;
  num? pressure;
  num? humidity;
  num? tempMin;
  num? tempMax;

  Main({this.temp, this.pressure, this.humidity, this.tempMin, this.tempMax});

  Main.fromJson(dynamic json) {
    temp = json['temp'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
  }
}

class Weather {
  num? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(dynamic json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class Coord {
  num? lon;
  num? lat;
  Coord({this.lon, this.lat});

  Coord.fromJson(dynamic json) {
    lon = json['lon'];
    lat = json['lat'];
  }
}
