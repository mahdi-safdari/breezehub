import 'package:equatable/equatable.dart';

abstract class DeleteCityStatus extends Equatable {}

class DeleteCityLoading extends DeleteCityStatus {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DeleteCityCompleted extends DeleteCityStatus {
  final String name;

  DeleteCityCompleted(this.name);
  @override
  // TODO: implement props
  List<Object?> get props => [name];
}

class DeleteCityError extends DeleteCityStatus {
  final String message;

  DeleteCityError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
