import 'package:breezehub/features/feature_favorite/domain/entities/city_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetAllCityStatus extends Equatable {}

class GetAllCityLoading extends GetAllCityStatus {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetAllCityCompleted extends GetAllCityStatus {
  final List<CityEntity> allCity;
  GetAllCityCompleted(this.allCity);

  @override
  // TODO: implement props
  List<Object?> get props => [allCity];
}

class GetAllCityError extends GetAllCityStatus {
  final String message;

  GetAllCityError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
