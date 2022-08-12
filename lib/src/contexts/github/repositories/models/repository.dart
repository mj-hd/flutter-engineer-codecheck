import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_viewer/src/resources/github/types.dart';

part 'repository.freezed.dart';

@freezed
class Repository with _$Repository {
  const factory Repository({
    required String id,
    required String org,
    required String name,
  }) = _Repository;

  factory Repository.fromGithubApi(GithubRepository repo) => Repository(
        id: repo.id.toString(),
        org: repo.owner?.name ?? repo.owner?.login ?? 'unknown',
        name: repo.name,
      );
}
