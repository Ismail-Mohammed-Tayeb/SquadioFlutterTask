import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:squadio_flutter_task/controllers/people_controller.dart';
import 'package:squadio_flutter_task/views/homepage/homepage.dart';
import 'package:squadio_flutter_task/views/homepage/homepage_state.dart';

void main() {
  testWidgets('Test Growable List For Infinite Scrolling', (tester) async {
    //initial Length Of Items Before Calling Test
    int initialLength = HomePageState.currentData.length;
    await PeopleController.getPeople();
    await tester.pumpWidget(const HomePage());

    final list = find.byKey(const ValueKey('PeopleListView'));
    //ID for finding the first element
    final itemFinder = find.byKey(const ValueKey('LastElement'));

    await tester.scrollUntilVisible(
      itemFinder,
      500,
      scrollable: list,
    );
    // Verify that the item contains the correct text.
    expect(HomePageState.currentData.length, greaterThan(initialLength));
  });
}
