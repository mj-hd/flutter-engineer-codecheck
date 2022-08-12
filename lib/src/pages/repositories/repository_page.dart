import 'package:flutter/material.dart';

class RepositoryPage extends StatelessWidget {
  const RepositoryPage({
    required this.org,
    required this.name,
    super.key,
  });

  final String org;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Repository: $org/$name',
            ),
          ],
        ),
      ),
    );
  }
}
