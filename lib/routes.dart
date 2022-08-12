import 'package:github_viewer/src/pages/home_page.dart';
import 'package:github_viewer/src/pages/repositories/repository_page.dart';
import 'package:go_router/go_router.dart';

final routes = [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(path: '/repositories', redirect: (state) => '/'),
  GoRoute(path: '/repositories/:org', redirect: (state) => '/'),
  GoRoute(
    path: '/repositories/:org/:name',
    builder: (context, state) => RepositoryPage(
      org: state.params['org']!,
      name: state.params['name']!,
    ),
  ),
];
