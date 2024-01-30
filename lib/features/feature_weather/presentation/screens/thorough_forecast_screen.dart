import 'dart:ui';

import 'package:breezehub/core/assets.dart';
import 'package:breezehub/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:breezehub/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/current_weather_status.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/forecast_days_status.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:breezehub/features/feature_weather/presentation/widgets/forecast_weather_items.dart';
import 'package:breezehub/screens/widgets/box_generator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForecastDetailsPage extends StatelessWidget {
  const ForecastDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff2E335A),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Ellipse 4
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(Assets.ellipse4, width: size.width, height: 425, fit: BoxFit.cover),
            ),

            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  surfaceTintColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  pinned: false,
                  floating: true,
                  snap: false,
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  elevation: 0,
                  toolbarHeight: 104,
                  title: BlocBuilder<HomeBloc, HomeState>(
                    builder: (BuildContext context, HomeState state) {
                      if (state.currentWeatherStatus is CurrentWeatherLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CupertinoActivityIndicator(color: Colors.white, radius: 15),
                          ),
                        );
                      }
                      if (state.currentWeatherStatus is CurrentWeatherCompleted) {
                        final CurrentWeatherCompleted currentWeatherCompleted = state.currentWeatherStatus as CurrentWeatherCompleted;
                        final CurrentCityEntity cityEntity = currentWeatherCompleted.cityEntity;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(cityEntity.name!, style: const TextStyle(color: Colors.white, fontSize: 34)),
                            Text(
                              '${cityEntity.main!.temp!.round()}\u00b0 | ${cityEntity.weather![0].description}',
                              style: TextStyle(
                                color: const Color(0xffEBEBF5).withOpacity(0.6),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        );
                      }
                      if (state.currentWeatherStatus is CurrentWeatherError) {
                        return SizedBox(
                          width: size.width,
                          child: const Text('Error'),
                        );
                      }
                      return Container(color: Colors.purpleAccent);
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Ellipse 5
                      Image.asset(Assets.ellipse5, width: 352, height: 352, fit: BoxFit.cover, filterQuality: FilterQuality.high),
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(44)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                          child: Container(
                            width: size.width,
                            decoration: BoxDecoration(
                              color: const Color(0xff2E335A).withOpacity(0.26),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(45)),
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.topCenter,
                              children: [
                                // Ellipse 1
                                Positioned(top: 0, right: 0, child: Image.asset(Assets.ellipse1)),
                                // Ellipse 2
                                Positioned(top: 0, child: Image.asset(Assets.ellipse2)),
                                // Ellipse 3
                                Positioned(top: 0, child: Image.asset(Assets.ellipse3)),

                                Column(
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 48,
                                      margin: const EdgeInsets.only(top: 16),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff000000).withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    // Hourly Forecast 5 Days
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Text(
                                        'Hourly Forecast',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: const Color(0xffEBEBF5).withOpacity(0.6),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // Divider
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Divider(color: Colors.white.withOpacity(0.2), height: 10),
                                        Positioned(
                                          left: size.width / 3.5,
                                          child: Image.asset(Assets.underline, color: const Color(0xffDA99DD)),
                                        ),
                                      ],
                                    ),
                                    // ListView
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: SizedBox(
                                        height: 146,
                                        width: size.width,
                                        child: BlocBuilder<HomeBloc, HomeState>(
                                          builder: (context, state) {
                                            if (state.forecastDaysStatus is ForecastDaysLoading) {
                                              return const Center(
                                                child: CupertinoActivityIndicator(color: Colors.white),
                                              );
                                            }
                                            if (state.forecastDaysStatus is ForecastDaysCompleted) {
                                              final ForecastDaysCompleted daysCompleted = state.forecastDaysStatus as ForecastDaysCompleted;
                                              final ForecastDaysEntity daysEntity = daysCompleted.daysEntity;

                                              return ForecastWeatherItems(daysEntity: daysEntity);
                                            }
                                            return Container();
                                          },
                                        ),
                                      ),
                                    ),
                                    // AIR QUALITY
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                                      child: Container(
                                        height: 158,
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                                        decoration: BoxDecoration(
                                          color: const Color(0xff24234E),
                                          borderRadius: const BorderRadius.all(Radius.circular(22)),
                                          border: Border.all(
                                            color: Colors.grey.withOpacity(0.4),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  CupertinoIcons.circle_grid_hex,
                                                  size: 18,
                                                  color: const Color(0xffEBEBF5).withOpacity(0.6),
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  'AIR QUALITY',
                                                  style: TextStyle(
                                                    color: const Color(0xffEBEBF5).withOpacity(0.6),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Text(
                                              '3-Low Health Risk',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 10,
                                              child: SliderTheme(
                                                data: const SliderThemeData(
                                                  trackHeight: 3,
                                                  thumbShape: RoundSliderThumbShape(
                                                    enabledThumbRadius: 5,
                                                  ),
                                                ),
                                                child: Slider(
                                                  value: 0.1,
                                                  onChanged: (double value) {},
                                                ),
                                              ),
                                            ),
                                            const Divider(thickness: 0.2),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text(
                                                  'See more',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Icon(
                                                  CupertinoIcons.chevron_right,
                                                  color: const Color(0xffEBEBF5).withOpacity(0.6),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // UV INDEX & SUNRISE
                                    BoxGenerator(
                                      boxIcon1: CupertinoIcons.sun_max_fill,
                                      boxIcon2: CupertinoIcons.sunrise_fill,
                                      boxTitle1: 'UV INDEX',
                                      boxTitle2: 'SUNRISE',
                                      content1: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            '4 Moderate',
                                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                          Center(child: Image.asset(Assets.uvIndex, width: 50, height: 50, color: const Color(0xff48319D))),
                                        ],
                                      ),
                                      content2: const Column(
                                        children: [
                                          Text('5:28 AM', style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
                                          Text('Sunset 7:25PM', style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    // WIND & RAINFALL
                                    BoxGenerator(
                                      boxIcon1: CupertinoIcons.wind,
                                      boxIcon2: CupertinoIcons.drop_fill,
                                      boxTitle1: 'WIND',
                                      boxTitle2: 'RAINFALL',
                                      content1: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          RichText(
                                            text: const TextSpan(
                                              text: '9.7',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 26,
                                                color: Colors.white,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: ' km/h',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SvgPicture.asset(Assets.wind, width: 50, height: 50),
                                        ],
                                      ),
                                      content2: const Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '1.8 mm',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'in last hour',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            '1.2 mm expected in next 24h.',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // FEELS LIKE & HUMIDITY
                                    const BoxGenerator(
                                      boxIcon1: CupertinoIcons.thermometer,
                                      boxIcon2: Icons.waves,
                                      boxTitle1: 'FEELS LIKE',
                                      boxTitle2: 'HUMIDITY',
                                      content1: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            '19\u00b0',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Similar to the actual temperature',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      content2: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            '90%',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'The dew point is 17 right now.',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // VISIBILITY & PRESSURE
                                    const BoxGenerator(
                                      boxIcon1: CupertinoIcons.eye_solid,
                                      boxIcon2: CupertinoIcons.gauge,
                                      boxTitle1: 'VISIBILITY',
                                      boxTitle2: 'PRESSURE',
                                      content1: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            '8 km',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Similar to the actual temperature',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
