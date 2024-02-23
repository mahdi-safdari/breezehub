import 'package:bloc/bloc.dart';

class ChangeStackCubit extends Cubit<int> {
  ChangeStackCubit() : super(0);

  void changeStackIndexHourly() {
    emit(0);
  }

  void changeStackIndexDaily() {
    emit(1);
  }
}
