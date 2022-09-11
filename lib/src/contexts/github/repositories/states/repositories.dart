import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_viewer/src/contexts/github/repositories/models/repository.dart';
import 'package:github_viewer/src/resources/github/repositories.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'repositories.freezed.dart';

@freezed
class GithubRepositoriesParam with _$GithubRepositoriesParam {
  const factory GithubRepositoriesParam({
    required String query,
    int? page,
    int? perPage,
  }) = _GithubRepositoriesParam;
}

final githubRepositoriesProvider = FutureProvider.family
    .autoDispose<List<Repository>, GithubRepositoriesParam>(
  (ref, param) async {
    if (param.query.isEmpty) return [];

    final resource = ref.watch(githubRepositoriesResourceProvider);

    final response = await resource.searchRepositories(
      query: param.query,
      page: param.page,
      perPage: param.perPage,
    );

    // TODO: githubRepositoryProviderと同じデータが取得できるので、どこかにキャッシュを置いても良さそう

    return response.items.map(Repository.fromGithubApi).toList(growable: false);
  },
  cacheTime: const Duration(minutes: 1),
);
