import 'package:github_viewer/src/resources/github/client.dart';
import 'package:github_viewer/src/resources/github/types.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final githubRepositoriesResourceProvider = Provider((ref) {
  final client = ref.watch(githubApiClientProvider);

  return GithubRepositoriesResource(client);
});

class GithubRepositoriesResource {
  GithubRepositoriesResource(this._client);

  final GithubApiClient _client;

  Future<GithubSearchRepositoriesResponse> searchRepositories({
    required String query,
    int? page,
    int? perPage,
  }) async {
    const endpoint = 'https://api.github.com/search/repositories';

    final json = await _client.getGithubJson(endpoint, {
      'q': query,
      'per_page': '${perPage ?? 30}',
      'page': '${page ?? 1}',
    });

    return GithubSearchRepositoriesResponse.fromJson(json);
  }

  Future<GithubRepository> getRepository({
    required String owner,
    required String repo,
  }) async {
    final endpoint =
        'https://api.github.com/repos/${Uri.encodeComponent(owner)}/${Uri.encodeComponent(repo)}';

    final json = await _client.getGithubJson(endpoint, {});

    return GithubRepository.fromJson(json);
  }
}
