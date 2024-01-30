import 'dart:ui';

import 'package:breezehub/core/assets.dart';
import 'package:breezehub/screens/forecast_details_page.dart';
import 'package:breezehub/screens/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
                  Color(0xff3A3F54),
                  Colors.transparent,
                ],
              )),
            ),
            // Home Background Image
            Positioned(bottom: 150, child: Image.asset(Assets.house, width: size.width)),
            // weather
            Weather(size: size),
            // Model
            ForecastWeather(size: size),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: MyBottomNavigationBar(size: size),
    );
  }
}

class ForecastWeather extends StatelessWidget {
  final Size size;
  const ForecastWeather({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(44)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            height: 335,
            width: size.width,
            decoration: BoxDecoration(
              color: const Color(0xff2E335A).withOpacity(0.26),
              border: Border.symmetric(
                horizontal: BorderSide(color: Colors.white.withOpacity(0.2), width: 2.5),
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(45)),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                // Ellipse 1
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(Assets.ellipse1),
                ),
                // Ellipse 2
                Positioned(
                  top: 0,
                  child: Image.asset(Assets.ellipse2),
                ),
                // Ellipse 3
                Positioned(
                  top: 0,
                  child: Image.asset(Assets.ellipse3),
                ),
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
                    // Hourly Forecast & Weekly Forecast
                    Padding(
                      padding: const EdgeInsets.only(top: 16, right: 30, left: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hourly Forecast',
                            style: TextStyle(
                              fontSize: 15,
                              color: const Color(0xffEBEBF5).withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Weekly Forecast',
                            style: TextStyle(
                              fontSize: 15,
                              color: const Color(0xffEBEBF5).withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Divider
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Divider(color: Colors.white.withOpacity(0.2), height: 10),
                        RotatedBox(
                          quarterTurns: 0,
                          child: Image.asset(
                            Assets.underline,
                            color: const Color(0xffDA99DD),
                          ),
                        ),
                      ],
                    ),

                    // ListView
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: SizedBox(
                        height: 146,
                        width: size.width,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(left: 20),
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: 10,
                          clipBehavior: Clip.none,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 60,
                              height: 146,
                              margin: const EdgeInsets.only(right: 16),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              decoration: ShapeDecoration(
                                color: const Color(0x3348319D),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: Colors.white.withOpacity(0.20000000298023224),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                shadows: const [
                                  BoxShadow(color: Color(0x3F000000), blurRadius: 10, offset: Offset(5, 4), spreadRadius: 0),
                                ],
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    '12 AM',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      // height: 0.09,
                                      letterSpacing: -0.50,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: 60,
                                    height: 42,
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Positioned(
                                          child: Image.asset(Assets.weatherIcon, width: 45, height: 45),
                                        ),
                                        const Visibility(
                                          visible: false,
                                          child: Positioned(
                                            top: 30,
                                            child: Text(
                                              '30%',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF40CBD8),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                height: 0.11,
                                                letterSpacing: -0.08,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    '19°',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      // height: 0.06,
                                      letterSpacing: 0.38,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: 93,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Tap Bar
          Positioned(
            bottom: 0,
            child: SvgPicture.asset(
              Assets.rectangle,
              width: size.width,
            ),
          ),
          SvgPicture.asset(Assets.subtract, width: 250),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const WeatherPage(),
                ),
              );
            },
            child: SvgPicture.asset(Assets.button, width: 100),
          ),
          Positioned(
            left: 25,
            bottom: 25,
            child: SvgPicture.asset(Assets.hover, height: 44),
          ),
          Positioned(
            right: 25,
            bottom: 25,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => const ForecastDetailsPage()),
                );
              },
              child: SvgPicture.asset(Assets.listIcon, height: 44),
            ),
          ),
        ],
      ),
    );
  }
}

class Weather extends StatelessWidget {
  const Weather({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: size.width / 5),
      child: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Montreal',
              style: TextStyle(
                fontSize: 34,
                height: 0,
                color: Colors.white,
              ),
            ),
            const Text(
              '19\u00b0',
              style: TextStyle(
                height: 0,
                fontSize: 96,
                color: Colors.white,
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              'Mostly Clear',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xffEBEBF5).withOpacity(0.6)),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'H:24\u00b0',
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Text(
                  'L:18\u00b0',
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            // const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
