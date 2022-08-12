import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logger = Logger();

/// main関数でロギング周りの初期化を行う際に使用
void initializeLogging() {
  if (kDebugMode || kProfileMode) {
    Logger.level = Level.debug;

    FlutterError.onError = (details) {
      logger.e(
        'FlutterError',
        details.exception,
        details.stack,
      );
    };
  }

  if (kReleaseMode) {
    Logger.level = Level.error;
  }
}
