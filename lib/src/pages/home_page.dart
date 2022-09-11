import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:github_viewer/src/contexts/github/repositories/states/repositories.dart';
import 'package:github_viewer/src/contexts/github/repositories/ui/repository_list.dart';
import 'package:github_viewer/src/contexts/github/repositories/ui/search_field.dart';
import 'package:github_viewer/src/utils/hooks/use_handle_async_value_errors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final param = useState(const GithubRepositoriesParam(query: ''));
    final repositories = ref.watch(githubRepositoriesProvider(param.value));

    useHandleAsyncValueErrors([repositories]);

    return Scaffold(
      appBar: AppBar(title: const Text('Github Viewer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SearchField(
              onChanged: (text) {
                param.value = param.value.copyWith(
                  query: text,
                  page: 1,
                );
              },
            ),
            Expanded(
              child: repositories.isLoading && !repositories.hasValue
                  ? const Center(child: CircularProgressIndicator())
                  : RepositoryList(
                      repositories: repositories.value!,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
