abstract class DataState<T> {
  final T? data;
  final String? errorMessage;

  DataState({this.data, this.errorMessage});
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T data) : super(data: data, errorMessage: null);
}

class DataFailed<T> extends DataState<T> {
  DataFailed(String errorMessage) : super(data: null, errorMessage: errorMessage);
}
