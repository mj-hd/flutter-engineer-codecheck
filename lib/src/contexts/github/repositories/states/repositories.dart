import 'package:github_viewer/src/contexts/github/repositories/models/repository.dart';
import 'package:github_viewer/src/resources/github/repositories.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final githubRepositoriesProvider =
    FutureProvider.family.autoDispose<List<Repository>, String>(
  (ref, query) async {
    final resource = ref.watch(githubRepositoriesResourceProvider);

    final response = await resource.searchRepositories(query: query);

    return response.items.map(Repository.fromGithubApi).toList(growable: false);
  },
  cacheTime: const Duration(minutes: 1),
);
