import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_viewer/src/resources/github/types.dart';

part 'repository.freezed.dart';

@freezed
class Repository with _$Repository {
  const factory Repository({
    required String id,
    required String org,
    required String name,
    required String? language,
    required String? ownerIcon,
    required String? ownerName,
    required int stars,
    required int forks,
    required int watchers,
    required int issues,
  }) = _Repository;

  factory Repository.fromGithubApi(GithubRepository repo) => Repository(
        id: repo.id.toString(),
        org: repo.owner?.name ?? repo.owner?.login ?? 'unknown',
        name: repo.name,
        language: repo.language,
        ownerIcon: repo.owner?.avatarUrl,
        ownerName: repo.owner?.name,
        stars: repo.stargazersCount,
        forks: repo.forksCount,
        watchers: repo.watchersCount,
        issues: repo.openIssuesCount,
      );
}
