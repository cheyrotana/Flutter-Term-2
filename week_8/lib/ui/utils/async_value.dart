enum AsyncState { loading, success, error }
class AsyncValue<T> {
  final T? data;
  final Object? error;
  final bool isLoading;
  final AsyncState state;

  const AsyncValue.loading()
    : data = null,
      error = null,
      isLoading = true,
      state = AsyncState.loading;

  const AsyncValue.success(this.data)
    : error = null,
      isLoading = false,
      state = AsyncState.success;

  const AsyncValue.error(this.error)
    : data = null,
      isLoading = false,
      state = AsyncState.error;
}
