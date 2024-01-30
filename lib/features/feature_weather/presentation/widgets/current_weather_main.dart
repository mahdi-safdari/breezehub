import 'package:breezehub/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/current_weather_status.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentWeatherMain extends StatefulWidget {
  const CurrentWeatherMain({super.key, required this.size});

  final Size size;

  @override
  State<CurrentWeatherMain> createState() => _CurrentWeatherMainState();
}

class _CurrentWeatherMainState extends State<CurrentWeatherMain> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(CurrentWeatherEvent('Sast'));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.size.width / 5),
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (HomeState previous, HomeState current) {
          if (previous != current) {
            return true;
          } else {
            return false;
          }
        },
        builder: (BuildContext context, HomeState state) {
          if (state.currentWeatherStatus is CurrentWeatherLoading) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                width: 100,
                height: 100,
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 20,
                ),
              ),
            );
          }
          if (state.currentWeatherStatus is CurrentWeatherCompleted) {
            final CurrentWeatherCompleted currentWeatherCompleted = state.currentWeatherStatus as CurrentWeatherCompleted;
            final CurrentCityEntity cityEntity = currentWeatherCompleted.cityEntity;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  cityEntity.name!,
                  style: const TextStyle(
                    fontSize: 34,
                    height: 0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${cityEntity.main!.temp!.round()}\u00b0',
                  style: const TextStyle(
                    height: 0,
                    fontSize: 96,
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                Text(
                  cityEntity.weather![0].description!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xffEBEBF5).withOpacity(0.6)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'H:${cityEntity.main!.tempMax!.round()}\u00b0',
                      style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'L:${cityEntity.main!.tempMin!.round()}\u00b0',
                      style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // const SizedBox(height: 200),
              ],
            );
          }
          if (state.currentWeatherStatus is CurrentWeatherError) {
            return SizedBox(
              height: 800,
              width: widget.size.width,
              child: const Text('Error'),
            );
          }
          return Container();
        },
      ),
    );
  }
}
