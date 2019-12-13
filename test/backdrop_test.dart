import 'package:backdrop/backdrop.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Backdrop Smoke test", (WidgetTester tester) async {
    await tester.pumpWidget(Backdrop(
      appBarTitle: "",
      backLayer: null,
      frontLayer: null,
    ));
  });
}
