import 'dart:async';

class StreamHandler<T> {
  final StreamController<T> controller = StreamController<T>.broadcast();

  StreamSink<T> get sink => controller.sink;

  Stream<T> get stream => controller.stream;
}
