import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:github_viewer/src/contexts/github/repositories/states/repositories.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter.of(context);
    final query = useState('mj-hd');
    final repositories = ref.watch(githubRepositoriesProvider(query.value));

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hello World',
            ),
            ...repositories.when(
              data: (repositories) => [
                for (final repo in repositories)
                  ElevatedButton(
                    key: ValueKey(repo.id),
                    onPressed: () {
                      router
                          .go('/repositories/mj-hd/flutter-engineer-codecheck');
                    },
                    child: Text('Go To ${repo.id} detail page'),
                  ),
              ],
              error: (_, __) => [
                const Text('something wrong...'),
              ],
              loading: () => [
                const Text('loading...'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
