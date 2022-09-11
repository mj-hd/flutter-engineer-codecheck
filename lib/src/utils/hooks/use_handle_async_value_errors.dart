import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:github_viewer/src/utils/log.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void useHandleAsyncValueErrors(List<AsyncValue> values) {
  final context = useContext();
  final router = GoRouter.of(context);
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

        // TODO: より詳細なエラーメッセージの分岐
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('不明なエラーが発生しました')),
        );

        router.go('/');
      }
    },
    // ignore: exhaustive_keys
    [...values.map((val) => val.hasError)],
  );
}
