import 'package:chat_bot_git/chat_screen.dart';
import 'package:chat_bot_git/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ChatScreen widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the ChatScreen widget is being displayed.
    expect(find.byType(ChatScreen), findsOneWidget);
  });
}
