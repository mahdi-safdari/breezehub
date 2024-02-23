import 'package:breezehub/core/assets.dart';
import 'package:breezehub/core/utils/constants.dart';
import 'package:breezehub/features/feature_weather/presentation/widgets/current_weather_main.dart';
import 'package:breezehub/features/feature_weather/presentation/widgets/my_bottom_navigation_bar.dart';
import 'package:breezehub/features/feature_weather/presentation/widgets/weather_forecast_panel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(Assets.background),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Rectangle 362
              Container(
                width: size.width,
                height: size.height / 1.75,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.topCenter,
                    colors: [
                      Constants.scaffoldBackgroundColor,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              // Home Background Image
              Positioned(bottom: 150, child: Image.asset(Assets.house, width: size.width)),
              // main weather
              const Positioned(top: 0, child: CurrentWeatherMain()),
              // Model
              Positioned(bottom: 0, child: WeatherForecastPanel(size: size)),
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: MyBottomNavigationBar(size: size),
    );
  }
}
