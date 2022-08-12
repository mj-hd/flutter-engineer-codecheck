import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:github_viewer/src/utils/hooks/use_effect_once.dart';
import 'package:rxdart/rxdart.dart';

void useDebouncedTextChanged(
  TextEditingController controller,
  Duration timespan,
  ValueChanged<String> onChanged,
) {
  final streamController = useStreamController<String>();
  final onChangedRef = useRef(onChanged)..value = onChanged;

  useEffect(
    () {
      void listener() {
        streamController.sink.add(controller.text);
      }

      controller.addListener(listener);

      return () => controller.removeListener(listener);
    },
    [controller],
  );

  useEffectOnce(() {
    final sub = streamController.stream.debounceTime(timespan).listen((event) {
      Future.microtask(() => onChangedRef.value(event));
    });

    return () {
      sub.cancel();
    };
  });
}
