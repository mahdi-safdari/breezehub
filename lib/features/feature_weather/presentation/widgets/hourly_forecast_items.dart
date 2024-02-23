import 'package:breezehub/core/utils/constants.dart';
import 'package:breezehub/core/utils/date_converter.dart';
import 'package:breezehub/core/widgets/get_weather_icon.dart';
import 'package:breezehub/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/cubit/parameters_card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HourlyForecastItems extends StatelessWidget {
  final ForecastDaysEntity daysEntity;

  const HourlyForecastItems({super.key, required this.daysEntity});

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
        return SizedBox(
          height: 170,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 20),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: daysEntity.list!.length,
            clipBehavior: Clip.none,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                overlayColor: const MaterialStatePropertyAll(Colors.deepPurpleAccent),
                onTap: () {
                  BlocProvider.of<ParametersCardCubit>(context).changeParameterCard(index);
                },
                child: Container(
                  width: 85,
                  height: 146,
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: ShapeDecoration(
                    color: index == state ? Constants.selectItemColor : Constants.selectItemColor.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Constants.quaternary),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadows: const [
                      BoxShadow(color: Constants.shadowColor, blurRadius: 10, offset: Offset(5, 4), spreadRadius: 0),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateConverter.changeDtToDateTimeHourM(daysEntity.list![index].dt, daysEntity.city!.timezone),
                        style: theme.textTheme.labelMedium,
                      ),
                      Text(DateConverter.changeDtToDateTime(daysEntity.list![index].dt), style: theme.textTheme.labelLarge),
                      SizedBox(width: 45, height: 45, child: GetWeatherIcon.getIcon(daysEntity.list![index].weather![0].main!)),
                      Visibility(
                        visible: ((daysEntity.list![index].pop!) * 100) > 0,
                        child: Text('${(daysEntity.list![index].pop! * 100).round()}%', textAlign: TextAlign.center, style: theme.textTheme.labelSmall),
                      ),
                      const Gap(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${daysEntity.list![index].main!.tempMax!.round()}°', style: theme.textTheme.labelLarge),
                          const Gap(5),
                          Text('${daysEntity.list![index].main!.tempMin!.round()}°', style: theme.textTheme.labelLarge!.copyWith(color: Constants.secondary)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
