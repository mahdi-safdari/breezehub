import 'package:breezehub/core/utils/date_converter.dart';
import 'package:breezehub/core/widgets/get_weather_icon.dart';
import 'package:breezehub/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:breezehub/features/feature_weather/presentation/bloc/cubit/parameters_card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForecastWeatherItems extends StatelessWidget {
  final ForecastDaysEntity daysEntity;

  const ForecastWeatherItems({super.key, required this.daysEntity});

  @override
  Widget build(BuildContext context) {
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
                    color: index == state ? const Color(0xff48319D) : const Color(0xff48319D).withOpacity(0.2),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateConverter.changeDtToDateTimeHourM(daysEntity.list![index].dt, daysEntity.city!.timezone),
                        style: TextStyle(
                          color: const Color(0xffEBEBF5).withOpacity(0.6),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.50,
                        ),
                      ),
                      Text(
                        DateConverter.changeDtToDateTime(daysEntity.list![index].dt),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.50,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                        height: 8,
                        child: GetWeatherIcon.getIcon(daysEntity.list![index].weather![0].main!),
                      ),
                      Visibility(
                        visible: ((daysEntity.list![index].pop!) * 100) > 0,
                        child: Text(
                          '${(daysEntity.list![index].pop! * 100).round()}%',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF40CBD8),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            height: 0.11,
                            letterSpacing: -0.08,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${daysEntity.list![index].main!.tempMax!.round()}°',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.38,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${daysEntity.list![index].main!.tempMin!.round()}°',
                            style: TextStyle(
                              color: const Color(0xffEBEBF5).withOpacity(0.6),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.38,
                            ),
                          ),
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
