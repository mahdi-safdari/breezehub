import 'package:breezehub/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HourlyForecastList extends StatelessWidget {
  final String hourly;
  final String daily;
  final String temp;
  final String? tempMin;
  final num pop;
  final Widget icon;

  const HourlyForecastList({
    super.key,
    required this.hourly,
    required this.daily,
    required this.temp,
    this.tempMin,
    required this.pop,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: 70,
      height: 146,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(side: BorderSide(width: 1, color: Constants.quaternary), borderRadius: BorderRadius.circular(30)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Hourly
          Text(hourly, style: theme.textTheme.labelMedium),
          // Daily
          Text(daily, style: theme.textTheme.labelLarge),
          // Icon
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 32, height: 32, child: icon),
              Visibility(
                visible: (pop * 100) > 0,
                child: Text(
                  '${(pop * 100).round()}%',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall,
                ),
              ),
            ],
          ),
          // Temp
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$temp°', style: theme.textTheme.labelMedium!.copyWith(color: Constants.primary)),
              const Gap(2),
              Visibility(
                visible: tempMin != null,
                child: Text('$tempMin°', style: theme.textTheme.labelMedium),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
