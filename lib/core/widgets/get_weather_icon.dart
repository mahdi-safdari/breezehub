import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GetWeatherIcon {
  static Widget setIconForMain(String description) {
    if (description == "clear sky") {
      return const Image(image: AssetImage('assets/images/sun.png'));
    } else if (description == "few clouds") {
      return const Image(image: AssetImage('assets/images/sunny.png'));
    } else if (description == "scattered clouds") {
      return const Image(image: AssetImage('assets/images/sunny.png'));
    } else if (description == "broken clouds") {
      return const Image(image: AssetImage('assets/images/sun1.png'));
    } else if (description == "overcast clouds") {
      return const Image(image: AssetImage('assets/images/cloud.png'));
    } else if (description.contains("thunderstorm")) {
      return const Image(image: AssetImage('assets/images/rain.png'));
    } else if (description.contains("drizzle")) {
      return const Image(image: AssetImage('assets/images/cloudy.png'));
    } else if (description.contains("rain")) {
      return const Image(image: AssetImage('assets/images/heavy-rain.png'));
    } else if (description.contains("snow")) {
      return const Image(image: AssetImage('assets/images/snow.png'));
    } else if (description.contains("sleet")) {
      return const Image(image: AssetImage('assets/images/snow.png'));
    } else {
      return const Image(image: AssetImage('assets/images/wind1.png'));
    }
  }

  static Widget getIcon(String main) {
    switch (main) {
      case "Thunderstorm":
        return SvgPicture.asset('assets/icon/thunder.svg');

      case "Drizzle":
        return SvgPicture.asset('assets/icon/drizzle.svg');

      case "Rain":
        return SvgPicture.asset('assets/icon/rain.svg');

      case "Snow":
        return SvgPicture.asset('assets/icon/snow.svg');

      case "Clear":
        return SvgPicture.asset('assets/icon/clear.svg');

      case "Clouds":
        return SvgPicture.asset('assets/icon/cloud.svg');

      default:
        return SvgPicture.asset('assets/icon/cloud.svg');
    }
  }
}
