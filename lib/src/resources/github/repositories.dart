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
  }) async {
    const endpoint = 'https://api.github.com/search/repositories';

    final json = await _client.getGithubJson(endpoint, {'q': query});

    return GithubSearchRepositoriesResponse.fromJson(json);
  }
}

