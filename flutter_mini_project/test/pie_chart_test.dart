import 'package:flutter/material.dart';
import 'package:flutter_mini_project/components/news_component.dart';
import 'package:flutter_mini_project/view/screens/news_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mini_project/viewmodel/providers/news_provider.dart';

void main() {
  testWidgets('NewsScreen UI Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => NewsProvider(),
          child: NewsScreen(),
        ),
      ),
    );

    // Verify that the title is displayed.
    expect(find.text('News'), findsOneWidget);

    // Verify if CircularProgressIndicator is displayed when loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Simulate the loading of news data
    await tester.runAsync(() async {
      final newsProvider =
          Provider.of<NewsProvider>(tester.element(find.byType(NewsScreen)));
      await newsProvider.getNewsNow();
    });

    // Rebuild the widget to reflect changes
    await tester.pump();

    // Verify that CircularProgressIndicator is not displayed after loading
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // Verify if NewsComponent widgets are displayed based on the loaded news data
    expect(find.byType(NewsComponent), findsWidgets);

    // Perform actions such as tapping on widgets, etc., and add more assertions as needed for further testing.
  });
}
