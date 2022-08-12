import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void testProvider(
  Object description,
  List<Override> overrides,
  dynamic Function(ProviderContainer container, FakeAsync async) f,
) {
  return test(
    description,
    () => fakeAsync(
      (async) => f(
        ProviderContainer(
          overrides: overrides,
        ),
        async,
      ),
    ),
  );
}
