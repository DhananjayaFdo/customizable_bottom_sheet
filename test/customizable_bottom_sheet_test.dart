import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:customizable_bottom_sheet/customizable_bottom_sheet.dart';

void main() {
  group('CustomizableBottomSheet Tests', () {
    late List<String> testData;

    setUp(() {
      testData = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];
    });

    testWidgets('renders correctly with data', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  CustomizableBottomSheet.show<String>(context: context, data: testData, hint: 'Search', itemBuilder: (item) => Text(item), searchFilter: (item, query) => item.contains(query));
                },
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      // Tap button to show bottom sheet
      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Verify bottom sheet is shown
      expect(find.byType(CustomizableBottomSheet<String>), findsOneWidget);
    });

    testWidgets('displays all items initially', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  CustomizableBottomSheet.show<String>(context: context, data: testData, hint: 'Search', itemBuilder: (item) => Text(item), searchFilter: (item, query) => item.contains(query));
                },
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // All items should be visible
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('Cherry'), findsOneWidget);
    });

    testWidgets('filters items on search', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  CustomizableBottomSheet.show<String>(context: context, data: testData, hint: 'Search', itemBuilder: (item) => Text(item), searchFilter: (item, query) => item.toLowerCase().contains(query.toLowerCase()));
                },
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Enter search text
      await tester.enterText(find.byType(TextField), 'app');
      await tester.pumpAndSettle();

      // Only Apple should be visible
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsNothing);
    });

    testWidgets('shows empty state when no data', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  CustomizableBottomSheet.show<String>(context: context, data: [], hint: 'Search', itemBuilder: (item) => Text(item), searchFilter: (item, query) => item.contains(query));
                },
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      expect(find.text('No data available'), findsOneWidget);
      expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
    });

    testWidgets('shows no results state when search has no matches', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  CustomizableBottomSheet.show<String>(context: context, data: testData, hint: 'Search', itemBuilder: (item) => Text(item), searchFilter: (item, query) => item.toLowerCase().contains(query.toLowerCase()));
                },
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Search for non-existent item
      await tester.enterText(find.byType(TextField), 'xyz');
      await tester.pumpAndSettle();

      expect(find.text('No results found'), findsOneWidget);
      expect(find.byIcon(Icons.search_off), findsOneWidget);
    });

    testWidgets('displays title when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  CustomizableBottomSheet.show<String>(context: context, data: testData, hint: 'Search', title: 'Select Fruit', itemBuilder: (item) => Text(item), searchFilter: (item, query) => item.contains(query));
                },
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      expect(find.text('Select Fruit'), findsOneWidget);
    });

    testWidgets('shows checkboxes when enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  CustomizableBottomSheet.show<String>(context: context, data: testData, hint: 'Search', showCheckbox: true, isChecked: (item) => item == 'Apple', itemBuilder: (item) => Text(item), searchFilter: (item, query) => item.contains(query));
                },
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Check for checkbox icons
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.byIcon(Icons.circle_outlined), findsWidgets);
    });

    testWidgets('calls onItemSelected when item tapped', (WidgetTester tester) async {
      String? selectedItem;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  selectedItem = await CustomizableBottomSheet.show<String>(context: context, data: testData, hint: 'Search', itemBuilder: (item) => Text(item), searchFilter: (item, query) => item.contains(query));
                },
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Banana'));
      await tester.pumpAndSettle();

      expect(selectedItem, 'Banana');
    });

    testWidgets('close button dismisses bottom sheet', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  CustomizableBottomSheet.show<String>(context: context, data: testData, hint: 'Search', itemBuilder: (item) => Text(item), searchFilter: (item, query) => item.contains(query));
                },
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      expect(find.byType(CustomizableBottomSheet<String>), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.byType(CustomizableBottomSheet<String>), findsNothing);
    });

    testWidgets('clear button clears search', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  CustomizableBottomSheet.show<String>(context: context, data: testData, hint: 'Search', itemBuilder: (item) => Text(item), searchFilter: (item, query) => item.toLowerCase().contains(query.toLowerCase()));
                },
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Enter search text
      await tester.enterText(find.byType(TextField), 'app');
      await tester.pumpAndSettle();

      expect(find.text('Banana'), findsNothing);

      // Clear search
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pumpAndSettle();

      // All items should be visible again
      expect(find.text('Banana'), findsOneWidget);
    });

    testWidgets('sorts items when sort function provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  CustomizableBottomSheet.show<String>(context: context, data: ['Zebra', 'Apple', 'Mango'], hint: 'Search', sortItems: (items) => items..sort((a, b) => a.compareTo(b)), itemBuilder: (item) => Text(item), searchFilter: (item, query) => item.contains(query));
                },
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Items should be sorted alphabetically
      final texts = tester.widgetList<Text>(find.byType(Text));
      final itemTexts = texts.map((t) => t.data).where((d) => ['Apple', 'Mango', 'Zebra'].contains(d)).toList();

      expect(itemTexts, ['Apple', 'Mango', 'Zebra']);
    });

    testWidgets('shows custom empty widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  CustomizableBottomSheet.show<String>(context: context, data: [], hint: 'Search', emptyWidget: const Text('Custom Empty Message'), itemBuilder: (item) => Text(item), searchFilter: (item, query) => item.contains(query));
                },
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      expect(find.text('Custom Empty Message'), findsOneWidget);
    });

    testWidgets('shows edit and delete buttons when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  CustomizableBottomSheet.show<String>(context: context, data: testData, hint: 'Search', itemBuilder: (item) => Text(item), searchFilter: (item, query) => item.contains(query), onEdit: (item, index) {}, onDelete: (item, index) {});
                },
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.edit), findsWidgets);
      expect(find.byIcon(Icons.delete), findsWidgets);
    });
  });
}
