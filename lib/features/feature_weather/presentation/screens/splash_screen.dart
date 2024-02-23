import 'package:breezehub/core/assets.dart';
import 'package:breezehub/core/params/location_params.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:breezehub/features/feature_weather/presentation/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool checkRequest = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              Assets.welcome,
              width: size.width * 0.7,
            ),
            SvgPicture.asset(Assets.currentLocation, width: size.width, height: size.height * 0.4),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width * 0.8, size.height * 0.05),
                backgroundColor: const Color(0xff6C63FF),
              ),
              onPressed: () async {
                setState(() => checkRequest = true);

                BlocProvider.of<HomeBloc>(context).add(MainDataEvent(LocationParams(lat: 35.6944, lon: 51.4215)));
                context.pushReplacement(HomeScreen.routeName);
                setState(() => checkRequest = false);
              },
              child: checkRequest
                  ? const CupertinoActivityIndicator()
                  : Text(
                      'Start',
                      style: theme.textTheme.titleMedium!.apply(fontSizeFactor: 1.3, color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
