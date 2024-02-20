import 'package:breezehub/features/feature_favorite/domain/entities/city_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetCityStatus extends Equatable {}

class GetCityLoading extends GetCityStatus {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetCityCompleted extends GetCityStatus {
  final CityEntity? cityEntity;

  GetCityCompleted(this.cityEntity);
  @override
  // TODO: implement props
  List<Object?> get props => [cityEntity];
}

class GetCityError extends GetCityStatus {
  final String message;

  GetCityError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
