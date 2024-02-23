import 'dart:ui';

import 'package:breezehub/core/assets.dart';
import 'package:breezehub/core/params/location_params.dart';
import 'package:breezehub/core/utils/current_location.dart';
import 'package:breezehub/features/feature_favorite/presentation/screens/favorite_page.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:breezehub/features/feature_weather/presentation/screens/thorough_forecast_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
// import 'package:location/location.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  bool checkRequest = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: 93,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Tap Bar
          Positioned(
            bottom: 0,
            child: SvgPicture.asset(
              Assets.rectangle,
              width: widget.size.width,
            ),
          ),
          SvgPicture.asset(Assets.subtract, width: 250),
          GestureDetector(
            onTap: () {
              context.push(FavoritePage.routeName);
            },
            child: SvgPicture.asset(Assets.button, width: 100),
          ),
          Positioned(
            left: 25,
            bottom: 25,
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  checkRequest = true;
                });
                final Position data = await GetCurrentLocation.getCurrentPosition();
                if (!context.mounted) return;
                BlocProvider.of<HomeBloc>(context).add(
                  MainDataEvent(
                    LocationParams(lat: data.latitude, lon: data.longitude),
                  ),
                );
                setState(() {
                  checkRequest = false;
                });
              },
              child: SvgPicture.asset(Assets.hover, height: 44),
            ),
          ),
          Positioned(
            right: 25,
            bottom: 25,
            child: GestureDetector(
              onTap: () {
                context.push(ThoroughForecastScreen.routeName);
              },
              child: SvgPicture.asset(Assets.listIcon, height: 44),
            ),
          ),

          Visibility(
            visible: checkRequest,
            child: Positioned(
              top: 0,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                          'Please wait ',
                          style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.white),
                        ),
                        const CupertinoActivityIndicator(radius: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
