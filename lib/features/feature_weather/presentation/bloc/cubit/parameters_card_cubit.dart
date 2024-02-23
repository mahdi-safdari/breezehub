import 'package:bloc/bloc.dart';

class ParametersCardCubit extends Cubit<int> {
  ParametersCardCubit() : super(0);

  void changeParameterCard(int index) {
    emit(index);
  }
}
