import 'package:flutter/material.dart';
import 'package:github_viewer/src/contexts/github/repositories/states/repository.dart';
import 'package:github_viewer/src/utils/hooks/use_handle_async_value_errors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RepositoryPage extends HookConsumerWidget {
  const RepositoryPage({
    required this.org,
    required this.name,
    super.key,
  });

  final String org;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(
      githubRepositoryProvider(
        GithubRepositoryParam(
          owner: org,
          name: name,
        ),
      ),
    );

    useHandleAsyncValueErrors([repository]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Repository: $org/$name'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Repository: $org/$name',
            ),
            repository.isLoading && !repository.hasValue
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      if (repository.value!.ownerIcon != null)
                        Image.network(
                          repository.value!.ownerIcon!,
                          semanticLabel:
                              '${repository.value!.ownerName}のプロフィール画像',
                          width: 128,
                          height: 128,
                        ),
                      Text('Language: ${repository.value!.language}'),
                      Text('Stars: ${repository.value!.stars}'),
                      Text('Forks: ${repository.value!.forks}'),
                      Text('Watchers: ${repository.value!.watchers}'),
                      Text('Issues: ${repository.value!.issues}'),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
