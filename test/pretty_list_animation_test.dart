import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pretty_list_animation/pretty_list_animation.dart';

void main() {
  /// This test checks whether PrettyListAnimation widget correctly displays a list of items
  testWidgets('PrettyListAnimation should display items', (tester) async {
    /// Define a list of items to be displayed in the list
    final items = ['Text 1', 'Text 2', 'Text 3'];

    /// Build the widget tree and render the widget
    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          body: PrettyListAnimation(
            onRefresh: () async {},
            items: items,
            itemBuilder: (context, item, index, animation) {
              return Text(item);
            },
          ),
        ),
      ),
    );

    /// Check if each item is displayed on the screen
    expect(find.text('Text 1'), findsOneWidget);
    expect(find.text('Text 2'), findsOneWidget);
    expect(find.text('Text 3'), findsOneWidget);
  });

  testWidgets(
      'PrettyListAnimation should display loading indicator when isInfinite is true',
      (tester) async {
    /// Test case to check if [PrettyListAnimation] displays loading indicator when isInfinite is true

    /// It should render [CircularProgressIndicator] and 'Loading...' text widget when [PrettyListAnimation]'s

    /// isInfinite property is set to true and the widget is being loaded.
    final items = ['Text 1', 'Text 2', 'Text 3'];
    bool isLoading = true;

    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          body: PrettyListAnimation(
            onRefresh: () async {},
            items: items,
            itemBuilder: (context, item, index, animation) {
              return Text(item);
            },
            isInfinite: isLoading,
          ),
        ),
      ),
    );

    /// Test Steps:

    /// Create a list of items
    /// Set isLoading boolean to true to simulate loading state
    /// Pump the [PrettyListAnimation] widget with the items and the [itemBuilder] function to build each item
    /// Expect to find a [CircularProgressIndicator] widget
    /// Expect to find a 'Loading...' text widget
    /// Expected Result: The [PrettyListAnimation] widget should display a loading indicator when isInfinite is true.

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Loading...'), findsOneWidget);
  });
}
