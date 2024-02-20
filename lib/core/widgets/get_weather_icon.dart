import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GetWeatherIcon {
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
