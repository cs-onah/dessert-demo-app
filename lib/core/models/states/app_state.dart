sealed class AppState<T> {}

class InitialAppState<T> extends AppState<T> {}

class LoadingAppState<T> extends AppState<T> {}

class SuccessAppState<T> extends AppState<T> {
  final T data;
  SuccessAppState(this.data);
}

class FailureAppState<T> extends AppState<T> {
  final dynamic error;
  FailureAppState(this.error);
}
