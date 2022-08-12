import 'package:flutter_test/flutter_test.dart';

import 'package:github_viewer/main.dart';

void main() {
  testWidgets('Just smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
  });
}
