import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:github_viewer/src/contexts/github/repositories/models/repository.dart';
import 'package:go_router/go_router.dart';

class RepositoryList extends HookWidget {
  const RepositoryList({
    super.key,
    required this.repositories,
  });

  final List<Repository> repositories;

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);

    return ListView.custom(
      childrenDelegate: SliverChildBuilderDelegate(
        (context, i) {
          final repository = repositories[i];

          return MergeSemantics(
            child: GestureDetector(
              onTap: () {
                router.push(
                  '/repositories/${repository.org}/${repository.name}',
                );
              },
              child: Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('${repository.org}/${repository.name}'),
                ),
              ),
            ),
          );
        },
        childCount: repositories.length,
      ),
    );
  }
}
