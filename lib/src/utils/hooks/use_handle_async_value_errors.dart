import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:github_viewer/src/utils/log.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void useHandleAsyncValueErrors(List<AsyncValue> values) {
  final handledErrorMap = useRef(<int, bool>{});

  useEffect(
    // ignore: body_might_complete_normally_nullable
    () {
      for (final val in values) {
        final key = val.hashCode;
        if (!val.hasError) {
          handledErrorMap.value.remove(key);

          return;
        }

        if (handledErrorMap.value.containsKey(key)) {
          continue;
        }

        logger.e('useIsLoadingAsyncValues', val.error, val.stackTrace);
        handledErrorMap.value.putIfAbsent(key, () => true);
        // TODO: UIに表記する。スナックバー
      }
    },
    // ignore: exhaustive_keys
    [...values.map((val) => val.hasError)],
  );
}
