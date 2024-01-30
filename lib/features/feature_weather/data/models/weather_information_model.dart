class WeatherInformation {
  num? lat;
  num? lon;
  String? timezone;
  num? timezoneOffset;
  Current? current;
  List<Minutely>? minutely;
  List<Hourly>? hourly;
  List<Daily>? daily;
  List<Alerts>? alerts;

  WeatherInformation({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.current,
    this.minutely,
    this.hourly,
    this.daily,
    this.alerts,
  });

  factory WeatherInformation.fromJson(Map<String, dynamic> json) {
    List<Minutely> minutely = [];
    if (json['minutely'] != null) {
      json['minutely'].forEach((v) {
        minutely.add(Minutely.fromJson(v));
      });
    }

    List<Hourly> hourly = [];
    if (json['hourly'] != null) {
      json['hourly'].forEach((v) {
        hourly.add(Hourly.fromJson(v));
      });
    }

    List<Daily> daily = [];
    if (json['daily'] != null) {
      json['daily'].forEach((v) {
        daily.add(Daily.fromJson(v));
      });
    }

    List<Alerts> alerts = [];
    if (json['alerts'] != null) {
      json['alerts'].forEach((v) {
        alerts.add(Alerts.fromJson(v));
      });
    }

    return WeatherInformation(
      lat: json['lat'],
      lon: json['lon'],
      timezone: json['timezone'],
      timezoneOffset: json['timezone_offset'],
      current: json['current'] != null ? Current.fromJson(json['current']) : null,
      minutely: minutely.isNotEmpty ? minutely : null,
      hourly: hourly.isNotEmpty ? hourly : null,
      daily: daily.isNotEmpty ? daily : null,
      alerts: alerts.isNotEmpty ? alerts : null,
    );
  }
}

class Alerts {
  Alerts({
    this.senderName,
    this.event,
    this.start,
    this.end,
    this.description,
    this.tags,
  });

  Alerts.fromJson(dynamic json) {
    senderName = json['sender_name'];
    event = json['event'];
    start = json['start'];
    end = json['end'];
    description = json['description'];
    tags = json['tags'] != null ? json['tags'].cast<String>() : [];
  }
  String? senderName;
  String? event;
  num? start;
  num? end;
  String? description;
  List<String>? tags;
}

class Daily {
  Daily({
    this.dt,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.clouds,
    this.pop,
    this.rain,
    this.uvi,
  });

  Daily.fromJson(dynamic json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase'];
    temp = json['temp'] != null ? Temp.fromJson(json['temp']) : null;
    feelsLike = json['feels_like'] != null ? FeelsLike.fromJson(json['feels_like']) : null;
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    windGust = json['wind_gust'];
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather?.add(WeatherCondition.fromJson(v));
      });
    }
    clouds = json['clouds'];
    pop = json['pop'];
    rain = json['rain'];
    uvi = json['uvi'];
  }
  num? dt;
  num? sunrise;
  num? sunset;
  num? moonrise;
  num? moonset;
  num? moonPhase;
  Temp? temp;
  FeelsLike? feelsLike;
  num? pressure;
  num? humidity;
  num? dewPoint;
  num? windSpeed;
  num? windDeg;
  num? windGust;
  List<WeatherCondition>? weather;
  num? clouds;
  num? pop;
  num? rain;
  num? uvi;
}

class FeelsLike {
  FeelsLike({
    this.day,
    this.night,
    this.eve,
    this.morn,
  });

  FeelsLike.fromJson(dynamic json) {
    day = json['day'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }
  num? day;
  num? night;
  num? eve;
  num? morn;
}

class Temp {
  Temp({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  Temp.fromJson(dynamic json) {
    day = json['day'];
    min = json['min'];
    max = json['max'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }
  num? day;
  num? min;
  num? max;
  num? night;
  num? eve;
  num? morn;
}

class Hourly {
  Hourly({
    this.dt,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.pop,
  });

  Hourly.fromJson(dynamic json) {
    dt = json['dt'];
    temp = json['temp'];
    feelsLike = json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    uvi = json['uvi'];
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    windGust = json['wind_gust'];
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather?.add(WeatherCondition.fromJson(v));
      });
    }
    pop = json['pop'];
  }
  num? dt;
  num? temp;
  num? feelsLike;
  num? pressure;
  num? humidity;
  num? dewPoint;
  num? uvi;
  num? clouds;
  num? visibility;
  num? windSpeed;
  num? windDeg;
  num? windGust;
  List<WeatherCondition>? weather;
  num? pop;
}

class Minutely {
  Minutely({
    this.dt,
    this.precipitation,
  });

  Minutely.fromJson(dynamic json) {
    dt = json['dt'];
    precipitation = json['precipitation'];
  }
  num? dt;
  num? precipitation;
}

class Current {
  Current({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
  });

  Current.fromJson(dynamic json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp'];
    feelsLike = json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    uvi = json['uvi'];
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    windGust = json['wind_gust'];
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather?.add(WeatherCondition.fromJson(v));
      });
    }
  }
  num? dt;
  num? sunrise;
  num? sunset;
  num? temp;
  num? feelsLike;
  num? pressure;
  num? humidity;
  num? dewPoint;
  num? uvi;
  num? clouds;
  num? visibility;
  num? windSpeed;
  num? windDeg;
  num? windGust;
  List<WeatherCondition>? weather;
}

class WeatherCondition {
  WeatherCondition({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  WeatherCondition.fromJson(dynamic json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
  num? id;
  String? main;
  String? description;
  String? icon;
}
