# customizable_bottom_sheet

A highly customizable Flutter bottom sheet with built-in search functionality. Perfect for item selection, country pickers, and any searchable list interface.

[![pub package](https://img.shields.io/pub/v/customizable_bottom_sheet.svg)](https://pub.dev/packages/customizable_bottom_sheet)

## Features

✨ **Real-time Search** - Instant filtering as you type  
🎨 **Highly Customizable** - 30+ customization options  
✅ **Checkbox Support** - Built-in selection indicators  
🔧 **Edit/Delete Actions** - Per-item action buttons  
📱 **Keyboard Aware** - Adjusts for keyboard automatically  
🎭 **Smooth Animations** - Fade-in animation out of the box  
🎯 **Empty States** - Custom widgets for empty/no results  
🌈 **Theme Integration** - Respects Material Design theme  
⚡ **Zero Dependencies** - Only requires Flutter

## Preview

![Demo](https://via.placeholder.com/400x800?text=Demo+Screenshot)

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  customizable_bottom_sheet: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Example

```dart
import 'package:customizable_bottom_sheet/customizable_bottom_sheet.dart';

// Show bottom sheet and get selected item
final country = await CustomizableBottomSheet.show<Country>(
  context: context,
  data: countries,
  hint: 'Search country',
  itemBuilder: (country) => Text(country.name),
  searchFilter: (country, query) =>
    country.name.toLowerCase().contains(query.toLowerCase()),
);

if (country != null) {
  print('Selected: ${country.name}');
}
```

### Complete Example with All Features

```dart
final product = await CustomizableBottomSheet.show<Product>(
  context: context,
  data: products,
  hint: 'Search products',
  title: 'Select a Product',

  // Item builder
  itemBuilder: (product) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
      Text('\$${product.price}', style: TextStyle(color: Colors.grey)),
    ],
  ),

  // Search filter
  searchFilter: (product, query) =>
    product.name.toLowerCase().contains(query.toLowerCase()) ||
    product.category.toLowerCase().contains(query.toLowerCase()),

  // With checkboxes
  showCheckbox: true,
  isChecked: (product) => selectedProducts.contains(product),

  // With actions
  onEdit: (product, index) {
    // Handle edit
    print('Edit: ${product.name}');
  },
  onDelete: (product, index) {
    // Handle delete
    print('Delete: ${product.name}');
  },

  // Custom trailing
  trailingBuilder: (product) => product.isNew
    ? Chip(label: Text('NEW'))
    : null,

  // Sort items
  sortItems: (products) => products..sort((a, b) => a.name.compareTo(b.name)),

  // Customization
  backgroundColor: Colors.white,
  borderRadius: 24.0,
  maxHeightFraction: 0.9,
  autoCapitalize: true,
);
```

### Simple List Selection

```dart
final fruit = await CustomizableBottomSheet.show<String>(
  context: context,
  data: ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'],
  hint: 'Search fruit',
  title: 'Select Fruit',
  itemBuilder: (fruit) => Text(fruit),
  searchFilter: (fruit, query) =>
    fruit.toLowerCase().contains(query.toLowerCase()),
);
```

### Custom Empty State

```dart
await CustomizableBottomSheet.show<Item>(
  context: context,
  data: items,
  hint: 'Search',
  itemBuilder: (item) => Text(item.name),
  searchFilter: (item, query) => item.name.contains(query),

  // Custom empty state
  emptyWidget: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.inventory, size: 64, color: Colors.grey),
      SizedBox(height: 16),
      Text('No items in inventory'),
      ElevatedButton(
        onPressed: () => addNewItem(),
        child: Text('Add Item'),
      ),
    ],
  ),

  // Custom no results state
  noResultsWidget: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.search_off, size: 64),
      Text('No matching results'),
    ],
  ),
);
```

### Show Custom Widget

```dart
await CustomizableBottomSheet.showCustom(
  context: context,
  child: MyCustomBottomSheetContent(),
  borderRadius: 20,
  maxHeightFraction: 0.8,
);
```

## API Reference

### CustomizableBottomSheet.show()

#### Required Parameters

| Parameter      | Type                       | Description                |
| -------------- | -------------------------- | -------------------------- |
| `context`      | `BuildContext`             | Build context              |
| `data`         | `List<T>`                  | List of items to display   |
| `hint`         | `String`                   | Search field hint text     |
| `itemBuilder`  | `Widget Function(T)`       | Builder for each item      |
| `searchFilter` | `bool Function(T, String)` | Filter function for search |

#### Optional Parameters

| Parameter           | Type                         | Default     | Description                    |
| ------------------- | ---------------------------- | ----------- | ------------------------------ |
| `title`             | `String?`                    | null        | Header title                   |
| `showCheckbox`      | `bool`                       | false       | Show checkbox indicators       |
| `isChecked`         | `bool Function(T)?`          | null        | Determines if item is checked  |
| `sortItems`         | `List<T> Function(List<T>)?` | null        | Custom sort function           |
| `trailingBuilder`   | `Widget? Function(T)?`       | null        | Trailing widget builder        |
| `onEdit`            | `void Function(T, int)?`     | null        | Edit action callback           |
| `onDelete`          | `void Function(T, int)?`     | null        | Delete action callback         |
| `headerAction`      | `Widget?`                    | null        | Custom header action widget    |
| `isDismissible`     | `bool`                       | true        | Can dismiss by tapping outside |
| `enableDrag`        | `bool`                       | true        | Can drag to dismiss            |
| `emptyWidget`       | `Widget?`                    | null        | Custom empty state widget      |
| `noResultsWidget`   | `Widget?`                    | null        | Custom no results widget       |
| `maxHeightFraction` | `double`                     | 0.85        | Max height (0.0-1.0)           |
| `backgroundColor`   | `Color?`                     | null        | Background color               |
| `borderRadius`      | `double`                     | 20.0        | Top corner radius              |
| `autoCapitalize`    | `bool`                       | true        | Auto-capitalize text           |
| `searchDecoration`  | `InputDecoration?`           | null        | Custom search field decoration |
| `titleStyle`        | `TextStyle?`                 | null        | Title text style               |
| `itemTextStyle`     | `TextStyle?`                 | null        | Item text style                |
| `listPadding`       | `EdgeInsetsGeometry?`        | null        | Padding around list            |
| `itemHeight`        | `double?`                    | null        | Fixed item height              |
| `showDragHandle`    | `bool`                       | true        | Show drag handle               |
| `dragHandle`        | `Widget?`                    | null        | Custom drag handle             |
| `closeIcon`         | `IconData`                   | Icons.close | Close button icon              |
| `showCloseButton`   | `bool`                       | true        | Show close button              |
| `animationDuration` | `Duration`                   | 300ms       | Animation duration             |

## Examples

### Country Picker

```dart
class Country {
  final String name;
  final String code;
  final String flag;

  Country(this.name, this.code, this.flag);
}

final countries = [
  Country('United States', 'US', '🇺🇸'),
  Country('United Kingdom', 'GB', '🇬🇧'),
  Country('Canada', 'CA', '🇨🇦'),
];

final country = await CustomizableBottomSheet.show<Country>(
  context: context,
  data: countries,
  hint: 'Search country',
  title: 'Select Country',
  itemBuilder: (country) => Row(
    children: [
      Text(country.flag, style: TextStyle(fontSize: 24)),
      SizedBox(width: 12),
      Text(country.name),
    ],
  ),
  searchFilter: (country, query) =>
    country.name.toLowerCase().contains(query) ||
    country.code.toLowerCase().contains(query),
);
```

### Multi-Select with Checkboxes

```dart
class SelectableItem {
  final String name;
  bool isSelected;

  SelectableItem(this.name, {this.isSelected = false});
}

final items = [
  SelectableItem('Item 1'),
  SelectableItem('Item 2'),
  SelectableItem('Item 3'),
];

await CustomizableBottomSheet.show<SelectableItem>(
  context: context,
  data: items,
  hint: 'Search items',
  title: 'Select Items',
  showCheckbox: true,
  isChecked: (item) => item.isSelected,
  itemBuilder: (item) => Text(item.name),
  searchFilter: (item, query) => item.name.contains(query),
  onItemSelected: (item) {
    setState(() {
      item.isSelected = !item.isSelected;
    });
  },
  headerAction: TextButton(
    onPressed: () {
      final selected = items.where((i) => i.isSelected).toList();
      Navigator.pop(context, selected);
    },
    child: Text('Done'),
  ),
);
```

### With Edit/Delete Actions

```dart
await CustomizableBottomSheet.show<User>(
  context: context,
  data: users,
  hint: 'Search users',
  itemBuilder: (user) => ListTile(
    leading: CircleAvatar(child: Text(user.initials)),
    title: Text(user.name),
    subtitle: Text(user.email),
  ),
  searchFilter: (user, query) =>
    user.name.toLowerCase().contains(query) ||
    user.email.toLowerCase().contains(query),
  onEdit: (user, index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserScreen(user: user),
      ),
    );
  },
  onDelete: (user, index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete User'),
        content: Text('Delete ${user.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        users.removeAt(index);
      });
    }
  },
);
```

### Custom Styling

```dart
await CustomizableBottomSheet.show<Item>(
  context: context,
  data: items,
  hint: 'Search',
  itemBuilder: (item) => Text(item.name),
  searchFilter: (item, query) => item.name.contains(query),

  // Custom colors
  backgroundColor: Colors.grey.shade50,

  // Custom border
  borderRadius: 30.0,

  // Custom title
  title: 'Choose Item',
  titleStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),

  // Custom item style
  itemTextStyle: TextStyle(
    fontSize: 16,
    color: Colors.black87,
  ),

  // Custom search decoration
  searchDecoration: InputDecoration(
    hintText: 'Type to search...',
    prefixIcon: Icon(Icons.search, color: Colors.blue),
    filled: true,
    fillColor: Colors.blue.shade50,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide.none,
    ),
  ),

  // Custom height
  maxHeightFraction: 0.75,

  // Custom drag handle
  dragHandle: Container(
    width: 60,
    height: 6,
    margin: EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(3),
    ),
  ),
);
```

## Tips & Best Practices

### Efficient Searching

```dart
// Good: Case-insensitive search
searchFilter: (item, query) =>
  item.name.toLowerCase().contains(query.toLowerCase())

// Better: Search multiple fields
searchFilter: (item, query) {
  final q = query.toLowerCase();
  return item.name.toLowerCase().contains(q) ||
         item.description.toLowerCase().contains(q) ||
         item.tags.any((tag) => tag.toLowerCase().contains(q));
}
```

### Sorting Items

```dart
// Alphabetical sort
sortItems: (items) => items..sort((a, b) => a.name.compareTo(b.name))

// Custom sort with priority
sortItems: (items) {
  return items..sort((a, b) {
    if (a.isPriority != b.isPriority) {
      return a.isPriority ? -1 : 1;
    }
    return a.name.compareTo(b.name);
  });
}
```

### Handling Selection

```dart
// Single selection
final selected = await CustomizableBottomSheet.show<Item>(...);
if (selected != null) {
  // Use selected item
}

// Multi-selection (keep sheet open)
showCheckbox: true,
headerAction: TextButton(
  onPressed: () {
    final selected = items.where((i) => i.isSelected).toList();
    Navigator.pop(context, selected);
  },
  child: Text('Done (${selectedCount})'),
),
```

## Common Use Cases

✅ Country/Region selection  
✅ Language picker  
✅ Category selection  
✅ User/Contact picker  
✅ Product selection  
✅ Filter options  
✅ Settings selection  
✅ Multi-select lists  
✅ Tag selection  
✅ Any searchable list!

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Issues

Please file issues, bugs, or feature requests on our [issue tracker](https://github.com/DhananjayaFdo/customizable_bottom_sheet/issues).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you find this package useful, please give it a ⭐ on [GitHub](https://github.com/DhananjayaFdo/customizable_bottom_sheet)!

---

Made with ❤️ for the Flutter community
