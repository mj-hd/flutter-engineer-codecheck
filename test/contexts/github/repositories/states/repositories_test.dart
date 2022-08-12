import 'package:flutter_test/flutter_test.dart';
import 'package:github_viewer/src/contexts/github/repositories/models/repository.dart';
import 'package:github_viewer/src/contexts/github/repositories/states/repositories.dart';
import 'package:github_viewer/src/resources/github/repositories.dart';
import 'package:github_viewer/src/resources/github/types.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../utils.dart';

@GenerateMocks([
  GithubRepositoriesResource,
])
import 'repositories_test.mocks.dart';

void main() async {
  final mock = MockGithubRepositoriesResource();

  testProvider(
    'should query repositories',
    [
      githubRepositoriesResourceProvider.overrideWithValue(mock),
    ],
    (container, async) {
      const query = 'test-query';
      const data = GithubRepository(
        id: 1,
        name: 'flutter-engineer-codecheck',
        fullName: 'mj-hd/flutter-engineer-codecheck',
        stargazersCount: 2,
        watchersCount: 3,
        forksCount: 4,
        openIssuesCount: 5,
      );

      when(mock.searchRepositories(
        query: query,
      )).thenAnswer(
        (_) async => const GithubSearchRepositoriesResponse(
          totalCount: 1,
          items: [data],
        ),
      );

      var state = container.read(githubRepositoriesProvider(query));

      expect(state.isLoading, true);

      async.flushMicrotasks();

      state = container.read(githubRepositoriesProvider(query));

      expect(state.isLoading, false);
      expect(state.error, null);
      expect(state.value, [
        Repository.fromGithubApi(data),
      ]);
    },
  );
}
