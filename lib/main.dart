import 'package:flutter/material.dart';
import 'package:github_viewer/routes.dart';
import 'package:github_viewer/src/utils/log.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stack_trace/stack_trace.dart';

void main() {
  Chain.capture(
    () {
      WidgetsFlutterBinding.ensureInitialized();

      initializeLogging();

      runApp(App());
    },
    onError: (err, stack) {
      logger.e('zone', err, stack);
    },
  );
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  // See /routes.dart
  final _router = GoRouter(routes: routes);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: 'Github Viewer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
