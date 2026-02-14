import 'package:flutter/material.dart';
import 'package:customizable_bottom_sheet/customizable_bottom_sheet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Searchable Bottom Sheet Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), useMaterial3: true),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  String? selectedFruit;
  Country? selectedCountry;
  final List<SelectableItem> items = [SelectableItem('Item 1'), SelectableItem('Item 2'), SelectableItem('Item 3'), SelectableItem('Item 4'), SelectableItem('Item 5')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Searchable Bottom Sheet Examples'), backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildExampleCard(context, title: 'Basic Example', description: 'Simple list selection', onPressed: _showBasicExample, result: selectedFruit),
          const SizedBox(height: 16),
          _buildExampleCard(context, title: 'Country Picker', description: 'With flags and search', onPressed: _showCountryPicker, result: selectedCountry?.name),
          const SizedBox(height: 16),
          _buildExampleCard(context, title: 'Multi-Select with Checkboxes', description: 'Select multiple items', onPressed: _showMultiSelect, result: items.where((i) => i.isSelected).length.toString() + ' selected'),
          const SizedBox(height: 16),
          _buildExampleCard(context, title: 'With Edit/Delete Actions', description: 'Edit and delete buttons', onPressed: _showWithActions),
          const SizedBox(height: 16),
          _buildExampleCard(context, title: 'Custom Styling', description: 'Customized colors and styles', onPressed: _showCustomStyling),
          const SizedBox(height: 16),
          _buildExampleCard(context, title: 'Empty States', description: 'Custom empty and no results', onPressed: _showEmptyStates),
        ],
      ),
    );
  }

  Widget _buildExampleCard(BuildContext context, {required String title, required String description, required VoidCallback onPressed, String? result}) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(description, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600)),
                    if (result != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          result,
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showBasicExample() async {
    final fruits = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry', 'Fig', 'Grape', 'Honeydew'];

    final result = await CustomizableBottomSheet.show<String>(context: context, data: fruits, hint: 'Search fruit', title: 'Select Fruit', itemBuilder: (fruit) => Text(fruit), searchFilter: (fruit, query) => fruit.toLowerCase().contains(query.toLowerCase()));

    if (result != null) {
      setState(() {
        selectedFruit = result;
      });
    }
  }

  Future<void> _showCountryPicker() async {
    final countries = [Country('United States', 'US', '🇺🇸'), Country('United Kingdom', 'GB', '🇬🇧'), Country('Canada', 'CA', '🇨🇦'), Country('Australia', 'AU', '🇦🇺'), Country('Germany', 'DE', '🇩🇪'), Country('France', 'FR', '🇫🇷'), Country('Japan', 'JP', '🇯🇵'), Country('India', 'IN', '🇮🇳'), Country('Brazil', 'BR', '🇧🇷'), Country('China', 'CN', '🇨🇳')];

    final result = await CustomizableBottomSheet.show<Country>(
      context: context,
      data: countries,
      hint: 'Search country',
      title: 'Select Country',
      itemBuilder: (country) => Row(
        children: [
          Text(country.flag, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Text(country.name),
        ],
      ),
      searchFilter: (country, query) => country.name.toLowerCase().contains(query.toLowerCase()) || country.code.toLowerCase().contains(query.toLowerCase()),
      sortItems: (countries) => countries..sort((a, b) => a.name.compareTo(b.name)),
    );

    if (result != null) {
      setState(() {
        selectedCountry = result;
      });
    }
  }

  Future<void> _showMultiSelect() async {
    await CustomizableBottomSheet.show<SelectableItem>(
      context: context,
      data: items,
      hint: 'Search items',
      title: 'Select Items',
      showCheckbox: true,
      isChecked: (item) => item.isSelected,
      itemBuilder: (item) => Text(item.name),
      searchFilter: (item, query) => item.name.toLowerCase().contains(query.toLowerCase()),
      headerAction: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Done'),
      ),
    );

    setState(() {});
  }

  Future<void> _showWithActions() async {
    final users = [User('John Doe', 'john@example.com'), User('Jane Smith', 'jane@example.com'), User('Bob Johnson', 'bob@example.com'), User('Alice Williams', 'alice@example.com')];

    await CustomizableBottomSheet.show<User>(
      context: context,
      data: users,
      hint: 'Search users',
      title: 'Manage Users',
      itemBuilder: (user) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(user.email, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        ],
      ),
      searchFilter: (user, query) => user.name.toLowerCase().contains(query.toLowerCase()) || user.email.toLowerCase().contains(query.toLowerCase()),
      onEdit: (user, index) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Edit ${user.name}')));
      },
      onDelete: (user, index) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete ${user.name}')));
      },
    );
  }

  Future<void> _showCustomStyling() async {
    final colors = ['Red', 'Blue', 'Green', 'Yellow', 'Purple', 'Orange'];

    await CustomizableBottomSheet.show<String>(
      context: context,
      data: colors,
      hint: 'Search color',
      title: 'Custom Styled Sheet',
      itemBuilder: (color) => Text(color),
      searchFilter: (color, query) => color.toLowerCase().contains(query.toLowerCase()),
      backgroundColor: Colors.blue.shade50,
      borderRadius: 30.0,
      maxHeightFraction: 0.75,
      titleStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
      itemTextStyle: const TextStyle(fontSize: 16, color: Colors.black87),
      searchDecoration: InputDecoration(
        hintText: 'Type to search...',
        prefixIcon: const Icon(Icons.search, color: Colors.blue),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
      dragHandle: Container(
        width: 60,
        height: 6,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(3)),
      ),
    );
  }

  Future<void> _showEmptyStates() async {
    await CustomizableBottomSheet.show<String>(
      context: context,
      data: [],
      hint: 'Search',
      title: 'Empty List Example',
      itemBuilder: (item) => Text(item),
      searchFilter: (item, query) => item.contains(query),
      emptyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inbox, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('No items available'),
          const SizedBox(height: 16),
          ElevatedButton.icon(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.add), label: const Text('Add Item')),
        ],
      ),
    );
  }
}

// Models
class Country {
  final String name;
  final String code;
  final String flag;

  Country(this.name, this.code, this.flag);
}

class SelectableItem {
  final String name;
  bool isSelected;

  SelectableItem(this.name, {this.isSelected = false});
}

class User {
  final String name;
  final String email;

  User(this.name, this.email);
}
