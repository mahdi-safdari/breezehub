import 'package:breezehub/core/assets.dart';
import 'package:flutter/material.dart';

class HourlyForecastList extends StatelessWidget {
  const HourlyForecastList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                color: Colors.white.withOpacity(0.2),
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
    );
  }
}
