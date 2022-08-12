import 'package:freezed_annotation/freezed_annotation.dart';

part 'types.freezed.dart';
part 'types.g.dart';

@freezed
class GithubSearchRepositoriesResponse with _$GithubSearchRepositoriesResponse {
  const factory GithubSearchRepositoriesResponse({
    required int totalCount,
    required List<GithubRepository> items,
  }) = _GithubSearchRepositoriesResponse;

  factory GithubSearchRepositoriesResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$GithubSearchRepositoriesResponseFromJson(json);
}

@freezed
class GithubRepository with _$GithubRepository {
  const factory GithubRepository({
    required int id,
    required String name,
    required String fullName,
    required int stargazersCount,
    required int watchersCount,
    required int forksCount,
    required int openIssuesCount,
    String? language,
    GithubRepositoryOwner? owner,
  }) = _GithubRepository;

  factory GithubRepository.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$GithubRepositoryFromJson(json);
}

@freezed
class GithubRepositoryOwner with _$GithubRepositoryOwner {
  const factory GithubRepositoryOwner({
    required int id,
    String? name,
    required String login,
    required String avatarUrl,
  }) = _GithubRepositoryOwner;

  factory GithubRepositoryOwner.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$GithubRepositoryOwnerFromJson(json);
}
