import 'package:flutter/material.dart';
import 'package:github_viewer/src/utils/log.dart';
import 'package:go_router/go_router.dart';
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

  final _router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'Github Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Hello World',
            ),
          ],
        ),
      ),
    );
  }
}
