import 'package:breezehub/features/feature_favorite/domain/entities/city_entity.dart';
import 'package:equatable/equatable.dart';

abstract class FindCityStatus extends Equatable {}

class FindCityLoading extends FindCityStatus {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FindCityCompleted extends FindCityStatus {
  final CityEntity? cityEntity;

  FindCityCompleted(this.cityEntity);
  @override
  // TODO: implement props
  List<Object?> get props => [cityEntity];
}

class FindCityError extends FindCityStatus {
  final String message;

  FindCityError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
