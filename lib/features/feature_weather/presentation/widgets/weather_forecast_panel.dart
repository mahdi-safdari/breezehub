import 'dart:ui';

import 'package:breezehub/core/assets.dart';
import 'package:breezehub/core/utils/constants.dart';
import 'package:breezehub/core/utils/date_converter.dart';
import 'package:breezehub/core/widgets/get_weather_icon.dart';
import 'package:breezehub/features/feature_weather/data/models/weather_information_model.dart';
import 'package:breezehub/features/feature_weather/domain/entities/weather_information_entity.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/cubit/change_stack_cubit.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/weather_information_status.dart';
import 'package:breezehub/features/feature_weather/presentation/widgets/hourly_forecast_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherForecastPanel extends StatelessWidget {
  final Size size;

  const WeatherForecastPanel({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(44)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          height: 335,
          width: size.width,
          decoration: BoxDecoration(
            // color: const Color(0xff2E335A).withOpacity(0.26),
            border: Border.symmetric(
              horizontal: BorderSide(color: Constants.quaternary, width: 2.5),
            ),
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
                  // Indicator
                  Container(
                    height: 5,
                    width: 48,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Constants.indicator,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  // Hourly Forecast & Weekly Forecast
                  Padding(
                    padding: const EdgeInsets.only(top: 16, right: 30, left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<ChangeStackCubit>(context).changeStackIndexHourly();
                          },
                          child: Text('Hourly Forecast', style: theme.textTheme.titleMedium),
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<ChangeStackCubit>(context).changeStackIndexDaily();
                          },
                          child: Text('Daily Forecast', style: theme.textTheme.titleMedium),
                        ),
                      ],
                    ),
                  ),
                  // Divider
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Divider(),
                      BlocBuilder<ChangeStackCubit, int>(
                        builder: (context, state) {
                          return RotatedBox(
                            quarterTurns: state == 0 ? 0 : 2,
                            child: Image.asset(Assets.underline, color: Constants.underline),
                          );
                        },
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
                        buildWhen: (previous, current) {
                          if (previous.informationStatus != current.informationStatus) {
                            return true;
                          } else {
                            return false;
                          }
                        },
                        builder: (context, state) {
                          if (state.informationStatus is WeatherInformationLoading) {
                            return const Center(child: CupertinoActivityIndicator(color: Colors.white));
                          }
                          if (state.informationStatus is WeatherInformationCompleted) {
                            final WeatherInformationCompleted informationCompleted = state.informationStatus as WeatherInformationCompleted;
                            final WeatherInformationEntity informationEntity = informationCompleted.informationEntity;
                            return BlocBuilder<ChangeStackCubit, int>(
                              buildWhen: (previous, current) {
                                if (previous != current) {
                                  return true;
                                } else {
                                  return false;
                                }
                              },
                              builder: (BuildContext context, int state) {
                                return IndexedStack(
                                  index: state,
                                  children: [
                                    // Hourly Forecast
                                    ListView.builder(
                                      padding: const EdgeInsets.only(left: 20),
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: informationEntity.hourly!.length,
                                      clipBehavior: Clip.none,
                                      itemBuilder: (BuildContext context, int index) {
                                        final Hourly hourly = informationEntity.hourly![index];
                                        return HourlyForecastList(
                                          temp: hourly.temp!.round().toString(),
                                          pop: hourly.pop!,
                                          daily: DateConverter.changeDtToDateTime(hourly.dt),
                                          icon: GetWeatherIcon.getIcon(hourly.weather![0].main!),
                                          hourly: DateConverter.changeDtToDateTimeHour(hourly.dt, informationEntity.timezoneOffset),
                                        );
                                      },
                                    ),
                                    // Daily Forecast
                                    ListView.builder(
                                      padding: const EdgeInsets.only(left: 20),
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: informationEntity.daily!.length,
                                      clipBehavior: Clip.none,
                                      itemBuilder: (BuildContext context, int index) {
                                        final Daily daily = informationEntity.daily![index];
                                        return HourlyForecastList(
                                          hourly: DateConverter.changeDtToDateTimeM(daily.dt),
                                          daily: DateConverter.changeDtToDateTime(daily.dt),
                                          icon: GetWeatherIcon.getIcon(daily.weather![0].main!),
                                          pop: daily.pop!,
                                          temp: daily.temp!.max!.round().toString(),
                                          tempMin: daily.temp!.min!.round().toString(),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          return Container();
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
    );
  }
}
