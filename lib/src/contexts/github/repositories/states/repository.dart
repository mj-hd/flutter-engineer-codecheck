import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_viewer/src/contexts/github/repositories/models/repository.dart';
import 'package:github_viewer/src/resources/github/repositories.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'repository.freezed.dart';

@freezed
class GithubRepositoryParam with _$GithubRepositoryParam {
  const factory GithubRepositoryParam({
    required String owner,
    required String name,
  }) = _GithubRepositoryParam;
}

final githubRepositoryProvider =
    FutureProvider.family.autoDispose<Repository?, GithubRepositoryParam>(
  (ref, param) async {
    final resource = ref.watch(githubRepositoriesResourceProvider);

    final response = await resource.getRepository(
      owner: param.owner,
      repo: param.name,
    );

    return Repository.fromGithubApi(response);
  },
  cacheTime: const Duration(minutes: 1),
);
