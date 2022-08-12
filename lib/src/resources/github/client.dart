import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final githubApiClientProvider = Provider((_) => GithubApiClient(http.Client()));

class GithubApiClient extends http.BaseClient {
  GithubApiClient(this._inner);

  final http.Client _inner;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll({
      'accept': 'application/vnd.github+json',
    });

    return _inner.send(request);
  }

  Future<Map<String, dynamic>> getGithubJson(
    String uri,
    Map<String, dynamic>? queries,
  ) async {
    final url = Uri.parse(uri).replace(
      queryParameters: queries,
    );

    final res = await get(url);

    return jsonDecode(res.body);
  }
}
