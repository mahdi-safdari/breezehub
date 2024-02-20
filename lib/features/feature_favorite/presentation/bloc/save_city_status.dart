import 'package:breezehub/features/feature_favorite/domain/entities/city_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SaveCityStatus extends Equatable {}

class SaveCityInitial extends SaveCityStatus {
  @override
  List<Object?> get props => [];
}

class SaveCityLoading extends SaveCityStatus {
  @override
  List<Object?> get props => [];
}

class SaveCityCompleted extends SaveCityStatus {
  final CityEntity cityEntity;

  SaveCityCompleted(this.cityEntity);

  @override
  List<Object?> get props => [cityEntity];
}

class SaveCityError extends SaveCityStatus {
  final String message;

  SaveCityError(this.message);

  @override
  List<Object?> get props => [message];
}
