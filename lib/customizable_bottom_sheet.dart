/// A highly customizable searchable bottom sheet for Flutter.
///
/// This package provides a flexible bottom sheet widget with built-in search
/// functionality, perfect for country pickers, item selectors, and any
/// searchable list interface.
///
/// Features:
/// * Real-time search filtering
/// * Checkbox selection support
/// * Edit/Delete actions per item
/// * Custom empty states
/// * Smooth animations
/// * Keyboard-aware layout
/// * Highly customizable styling
/// * Static helper methods for easy usage
///
/// Example:
/// ```dart
/// final country = await CustomizableBottomSheet.show<Country>(
///   context: context,
///   data: countries,
///   hint: 'Search country',
///   itemBuilder: (country) => Text(country.name),
///   searchFilter: (country, query) =>
///     country.name.toLowerCase().contains(query.toLowerCase()),
/// );
/// ```
library customizable_bottom_sheet;

export 'src/customizable_bottom_sheet.dart';
