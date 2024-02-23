import 'dart:ui';

import 'package:breezehub/core/assets.dart';
import 'package:breezehub/core/utils/constants.dart';
import 'package:breezehub/core/utils/date_converter.dart';
import 'package:breezehub/features/feature_weather/data/models/forecast_days_model.dart';
import 'package:breezehub/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:breezehub/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/cubit/parameters_card_cubit.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/forecast_days_status.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/main_data_status.dart';
import 'package:breezehub/features/feature_weather/presentation/widgets/box_generator.dart';
import 'package:breezehub/features/feature_weather/presentation/widgets/hourly_forecast_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ThoroughForecastScreen extends StatelessWidget {
  static const String routeName = '/thorough_forecast';
  // static const String routeName = '/';
  const ThoroughForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return BlocProvider(
      create: (context) => ParametersCardCubit(),
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
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
                    leading: GestureDetector(
                      onTap: () => context.pop(),
                      child: const Icon(CupertinoIcons.left_chevron, size: 30),
                    ),
                    flexibleSpace: ClipRRect(
                        child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(color: Colors.transparent),
                    )),
                    surfaceTintColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: false,
                    snap: false,
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    elevation: 0,
                    toolbarHeight: 104,
                    title: BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (HomeState previous, HomeState current) {
                        if (previous.mainDataStatus != current.mainDataStatus) {
                          return true;
                        } else {
                          return false;
                        }
                      },
                      builder: (BuildContext context, HomeState state) {
                        if (state.mainDataStatus is MainDataLoading) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: CupertinoActivityIndicator(color: Colors.white, radius: 15),
                            ),
                          );
                        }
                        if (state.mainDataStatus is MainDataCompleted) {
                          final MainDataCompleted mainDataCompleted = state.mainDataStatus as MainDataCompleted;
                          final CurrentCityEntity cityEntity = mainDataCompleted.currentCityEntity;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(cityEntity.name!, style: theme.textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold)),
                              Text('${cityEntity.main!.temp!.round()}\u00b0 | ${cityEntity.weather![0].description}', style: theme.textTheme.titleLarge),
                              const Gap(30),
                            ],
                          );
                        }
                        if (state.mainDataStatus is MainDataError) {
                          final MainDataError mainDataError = state.mainDataStatus as MainDataError;
                          return Center(child: Text(mainDataError.message));
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
                                color: Constants.backgroundColor.withOpacity(0.26),
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
                                        margin: const EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                          color: Constants.indicator,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      // Hourly Forecast 5 Days
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Text('Hourly Forecast', style: theme.textTheme.titleMedium),
                                      ),
                                      // Divider
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          const Divider(),
                                          Positioned(
                                            left: size.width / 3.5,
                                            child: Image.asset(Assets.underline, color: Constants.underline),
                                          ),
                                        ],
                                      ),
                                      // ListView
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: BlocBuilder<HomeBloc, HomeState>(
                                          buildWhen: (previous, current) {
                                            if (previous.forecastDaysStatus != current.forecastDaysStatus) {
                                              return true;
                                            } else {
                                              return false;
                                            }
                                          },
                                          builder: (context, state) {
                                            if (state.forecastDaysStatus is ForecastDaysLoading) {
                                              return const Center(
                                                child: CupertinoActivityIndicator(color: Colors.white),
                                              );
                                            }
                                            if (state.forecastDaysStatus is ForecastDaysCompleted) {
                                              final ForecastDaysCompleted daysCompleted = state.forecastDaysStatus as ForecastDaysCompleted;
                                              final ForecastDaysEntity daysEntity = daysCompleted.daysEntity;

                                              return Column(
                                                children: [
                                                  HourlyForecastItems(daysEntity: daysEntity),
                                                  WeatherParametersCard(daysEntity: daysEntity),
                                                ],
                                              );
                                            }
                                            if (state.forecastDaysStatus is ForecastDaysError) {
                                              ForecastDaysError forecastDaysError = state.forecastDaysStatus as ForecastDaysError;
                                              return Center(child: Text(forecastDaysError.errorMessage));
                                            }

                                            return Container();
                                          },
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
      ),
    );
  }
}

class WeatherParametersCard extends StatelessWidget {
  final ForecastDaysEntity daysEntity;

  const WeatherParametersCard({super.key, required this.daysEntity});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<ParametersCardCubit, int>(
      buildWhen: (previous, current) {
        if (previous != current) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        final ListElement data = daysEntity.list![state];

        return Column(
          children: [
            // FEELS LIKE & HUMIDITY
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: BoxGenerator(
                boxIcon1: CupertinoIcons.thermometer,
                boxIcon2: Icons.waves,
                boxTitle1: 'FEELS LIKE',
                boxTitle2: 'HUMIDITY',
                content1: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${data.main!.feelsLike!.round()}\u00b0', style: theme.textTheme.headlineSmall),
                    Text('The parameter measures felt weather by humans', style: theme.textTheme.bodyLarge),
                  ],
                ),
                content2: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('${data.main!.humidity}%', style: theme.textTheme.headlineSmall),
                    Text('The dew point is 17 right now.', style: theme.textTheme.bodyLarge),
                  ],
                ),
              ),
            ),
            // RAIN & SUNRISE
            BoxGenerator(
              boxIcon1: CupertinoIcons.drop,
              boxIcon2: CupertinoIcons.wind,
              boxTitle1: 'RAIN',
              boxTitle2: 'WIND',
              content1: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${(data.pop! * 100).round()}%', style: theme.textTheme.headlineSmall),
                  Text('Probability of precipitation', style: theme.textTheme.bodyLarge),
                ],
              ),
              content2: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: data.wind!.speed.toString(),
                      style: theme.textTheme.headlineSmall,
                      children: [
                        TextSpan(text: ' km/h', style: theme.textTheme.titleMedium!.copyWith(color: Constants.primary, fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                  // SvgPicture.asset(Assets.wind, width: 50, height: 50),
                ],
              ),
            ),
            // AIR QUALITY
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Container(
                height: 158,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                decoration: BoxDecoration(
                  color: Constants.itemColor,
                  borderRadius: const BorderRadius.all(Radius.circular(22)),
                  border: Border.all(color: Constants.quaternary),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(CupertinoIcons.circle_grid_hex, size: 18, color: Constants.secondary),
                        const SizedBox(width: 5),
                        Text('AIR QUALITY', style: theme.textTheme.labelLarge!.copyWith(color: Constants.secondary)),
                      ],
                    ),
                    Text('currently not supported', style: theme.textTheme.bodyLarge),
                    Column(
                      children: [
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('See more', style: theme.textTheme.titleMedium),
                            Icon(CupertinoIcons.chevron_right, color: Constants.secondary),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // WIND & RAINFALL
            BoxGenerator(
              boxIcon1: CupertinoIcons.sunrise_fill,
              boxIcon2: CupertinoIcons.drop_fill,
              boxTitle1: 'SUNRISE',
              boxTitle2: 'RAINFALL',
              content1: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    DateConverter.changeDtToDateTimeHourM(daysEntity.city!.sunrise, daysEntity.city!.timezone),
                    style: theme.textTheme.headlineSmall,
                  ),
                  Text(
                    'Sunset ${DateConverter.changeDtToDateTimeHourM(daysEntity.city!.sunset, daysEntity.city!.timezone)}',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
              content2: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${data.rain != null ? data.rain!.h : 0} mm', style: theme.textTheme.headlineSmall),
                  Text('for last 3 hours', style: theme.textTheme.titleMedium),
                  const Spacer(),
                  Text('${data.rain != null ? data.rain!.h : 0} mm expected in next 24h.', style: theme.textTheme.bodyLarge),
                ],
              ),
            ),
            // VISIBILITY & PRESSURE
            BoxGenerator(
              boxIcon1: CupertinoIcons.eye_solid,
              boxIcon2: CupertinoIcons.gauge,
              boxTitle1: 'VISIBILITY',
              boxTitle2: 'PRESSURE',
              content1: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('${(data.visibility! * 0.001).round()} km', style: theme.textTheme.headlineSmall),
                  Text('Average visibility peaks at 10km', style: theme.textTheme.bodyLarge),
                ],
              ),
              content2: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('${data.main!.pressure} hPa', style: theme.textTheme.headlineSmall),
                  Text('Atmospheric pressure on the sea', style: theme.textTheme.bodyLarge),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
