import 'package:flutter/material.dart';

/// A highly customizable bottom sheet with built-in search functionality.
///
/// Features:
/// * Search functionality with real-time filtering
/// * Checkbox selection support
/// * Custom trailing widgets
/// * Edit/Delete actions per item
/// * Empty state customization
/// * Header customization
/// * Sort support
/// * Smooth animations
/// * Keyboard-aware layout
///
/// Example:
/// ```dart
/// CustomizableBottomSheet.show<Country>(
///   context: context,
///   data: countries,
///   hint: 'Search country',
///   itemBuilder: (country) => Text(country.name),
///   searchFilter: (country, query) =>
///     country.name.toLowerCase().contains(query.toLowerCase()),
///   onItemSelected: (country) => print(country.name),
/// )
/// ```
class CustomizableBottomSheet<T> extends StatefulWidget {
  /// List of items to display
  final List<T> data;

  /// Hint text for the search field
  final String searchHint;

  /// Header title (optional)
  final String? title;

  /// Builder for each list item
  final Widget Function(T item) itemBuilder;

  /// Search filter function
  final bool Function(T item, String query) searchFilter;

  /// Callback when an item is selected
  final ValueChanged<T> onItemSelected;

  /// Whether to show checkboxes
  final bool showCheckbox;

  /// Function to determine if an item is checked
  final bool Function(T item)? isChecked;

  /// Custom sort function
  final List<T> Function(List<T> items)? sortItems;

  /// Custom trailing widget
  final Widget? Function(T item)? trailingBuilder;

  /// Edit callback
  final void Function(T item, int index)? onEdit;

  /// Delete callback
  final void Function(T item, int index)? onDelete;

  /// Custom header action widget
  final Widget? headerAction;

  /// Whether the bottom sheet can be dismissed by tapping outside
  final bool isDismissible;

  /// Whether the bottom sheet can be dragged
  final bool enableDrag;

  /// Custom empty state widget
  final Widget? emptyWidget;

  /// Custom no results widget
  final Widget? noResultsWidget;

  /// Maximum height as a fraction of screen height (0.0 to 1.0)
  final double maxHeightFraction;

  /// Background color of the bottom sheet
  final Color? backgroundColor;

  /// Border radius for the top corners
  final double borderRadius;

  /// Whether to auto-capitalize text in items
  final bool autoCapitalize;

  /// Custom search field decoration
  final InputDecoration? searchDecoration;

  /// Custom title text style
  final TextStyle? titleStyle;

  /// Custom item text style
  final TextStyle? itemTextStyle;

  /// Padding around the list
  final EdgeInsetsGeometry? listPadding;

  /// Item height
  final double? itemHeight;

  /// Whether to show drag handle
  final bool showDragHandle;

  /// Custom drag handle widget
  final Widget? dragHandle;

  /// Close button icon
  final IconData closeIcon;

  /// Whether to show close button
  final bool showCloseButton;

  /// Animation duration
  final Duration animationDuration;

  const CustomizableBottomSheet({
    super.key,
    required this.data,
    required this.searchHint,
    required this.itemBuilder,
    required this.searchFilter,
    required this.onItemSelected,
    this.title,
    this.showCheckbox = false,
    this.isChecked,
    this.sortItems,
    this.trailingBuilder,
    this.onEdit,
    this.onDelete,
    this.headerAction,
    this.isDismissible = true,
    this.enableDrag = true,
    this.emptyWidget,
    this.noResultsWidget,
    this.maxHeightFraction = 0.85,
    this.backgroundColor,
    this.borderRadius = 20.0,
    this.autoCapitalize = true,
    this.searchDecoration,
    this.titleStyle,
    this.itemTextStyle,
    this.listPadding,
    this.itemHeight,
    this.showDragHandle = true,
    this.dragHandle,
    this.closeIcon = Icons.close,
    this.showCloseButton = true,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  /// Static method to show the searchable bottom sheet
  ///
  /// Returns the selected item when user taps on it, or null if dismissed.
  ///
  /// Example:
  /// ```dart
  /// final country = await CustomizableBottomSheet.show<Country>(
  ///   context: context,
  ///   data: countries,
  ///   hint: 'Search country',
  ///   itemBuilder: (country) => Text(country.name),
  ///   searchFilter: (country, query) =>
  ///     country.name.toLowerCase().contains(query),
  /// );
  /// ```
  static Future<T?> show<T>({
    required BuildContext context,
    required List<T> data,
    required String hint,
    required Widget Function(T item) itemBuilder,
    required bool Function(T item, String query) searchFilter,
    String? title,
    bool showCheckbox = false,
    bool Function(T item)? isChecked,
    List<T> Function(List<T> items)? sortItems,
    Widget? Function(T item)? trailingBuilder,
    void Function(T item, int index)? onEdit,
    void Function(T item, int index)? onDelete,
    Widget? headerAction,
    bool isDismissible = true,
    bool enableDrag = true,
    Widget? emptyWidget,
    Widget? noResultsWidget,
    double maxHeightFraction = 0.85,
    Color? backgroundColor,
    double borderRadius = 20.0,
    bool autoCapitalize = true,
    InputDecoration? searchDecoration,
    TextStyle? titleStyle,
    TextStyle? itemTextStyle,
    EdgeInsetsGeometry? listPadding,
    double? itemHeight,
    bool showDragHandle = true,
    Widget? dragHandle,
    IconData closeIcon = Icons.close,
    bool showCloseButton = true,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (context) => CustomizableBottomSheet<T>(
        data: data,
        searchHint: hint,
        itemBuilder: itemBuilder,
        searchFilter: searchFilter,
        onItemSelected: (item) => Navigator.pop(context, item),
        title: title,
        showCheckbox: showCheckbox,
        isChecked: isChecked,
        sortItems: sortItems,
        trailingBuilder: trailingBuilder,
        onEdit: onEdit,
        onDelete: onDelete,
        headerAction: headerAction,
        emptyWidget: emptyWidget,
        noResultsWidget: noResultsWidget,
        maxHeightFraction: maxHeightFraction,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        autoCapitalize: autoCapitalize,
        searchDecoration: searchDecoration,
        titleStyle: titleStyle,
        itemTextStyle: itemTextStyle,
        listPadding: listPadding,
        itemHeight: itemHeight,
        showDragHandle: showDragHandle,
        dragHandle: dragHandle,
        closeIcon: closeIcon,
        showCloseButton: showCloseButton,
        animationDuration: animationDuration,
      ),
    );
  }

  /// Show a custom widget in a bottom sheet with consistent styling
  ///
  /// Example:
  /// ```dart
  /// CustomizableBottomSheet.showCustom(
  ///   context: context,
  ///   child: MyCustomWidget(),
  /// )
  /// ```
  static Future<void> showCustom({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double borderRadius = 20.0,
    double maxHeightFraction = 0.85,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final theme = Theme.of(context);
        final screenHeight = MediaQuery.of(context).size.height;

        return Container(
          constraints: BoxConstraints(
            maxHeight: screenHeight * maxHeightFraction,
          ),
          decoration: BoxDecoration(
            color: backgroundColor ?? theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
            ),
          ),
          child: child,
        );
      },
    );
  }

  @override
  State<CustomizableBottomSheet<T>> createState() => _CustomizableBottomSheetState<T>();
}

class _CustomizableBottomSheetState<T> extends State<CustomizableBottomSheet<T>> with SingleTickerProviderStateMixin {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;

  List<T> _filteredList = [];
  List<T> _initialList = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _initializeList();
    _animationController.forward();
  }

  void _initializeList() {
    _initialList = widget.sortItems?.call(widget.data) ?? widget.data;
    _filteredList = _initialList;
  }

  void _filterList(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredList = _initialList;
      } else {
        _filteredList = _initialList.where((element) => widget.searchFilter(element, query)).toList();
      }
    });
  }

  String _capitalizeText(String text) {
    if (!widget.autoCapitalize || text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
    }).join(' ');
  }

  @override
  void didUpdateWidget(covariant CustomizableBottomSheet<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      _initializeList();
      _filterList(_searchController.text);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.borderRadius),
            topRight: Radius.circular(widget.borderRadius),
          ),
        ),
        constraints: BoxConstraints(
          maxHeight: screenHeight * widget.maxHeightFraction,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            if (widget.data.isEmpty)
              _buildEmptyState(context, widget.emptyWidget)
            else
              Flexible(
                child: Padding(
                  padding: widget.listPadding ??
                      EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: keyboardHeight > 0 ? keyboardHeight + 20 : bottomPadding + 20,
                      ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      _buildListContent(context),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.borderRadius),
          topRight: Radius.circular(widget.borderRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          if (widget.showDragHandle)
            widget.dragHandle ??
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: theme.dividerColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
          // Header row
          Row(
            children: [
              if (widget.showCloseButton) _buildCloseButton(context),
              if (widget.title != null)
                Expanded(
                  child: Text(
                    widget.title!,
                    textAlign: TextAlign.center,
                    style: widget.titleStyle ??
                        theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              widget.headerAction ?? SizedBox(width: widget.showCloseButton ? 40 : 0), // Balance for close button
            ],
          ),
          const SizedBox(height: 16),
          // Search field
          if (widget.data.isNotEmpty) _buildSearchField(context),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            widget.closeIcon,
            size: 20,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: _searchController,
      focusNode: _searchFocusNode,
      onChanged: _filterList,
      decoration: widget.searchDecoration ??
          InputDecoration(
            hintText: widget.searchHint,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _isSearching
                ? IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    onPressed: () {
                      _searchController.clear();
                      _filterList('');
                    },
                  )
                : null,
            filled: true,
            fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
    );
  }

  Widget _buildListContent(BuildContext context) {
    if (_filteredList.isEmpty) {
      return _buildEmptyState(
        context,
        _isSearching ? widget.noResultsWidget : null,
        message: _isSearching ? 'No results found' : 'No items available',
      );
    }

    return Flexible(
      child: Scrollbar(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: _filteredList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => _buildListItem(context, index),
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    final theme = Theme.of(context);
    final item = _filteredList[index];
    final hasActions = widget.onEdit != null || widget.onDelete != null;
    final isChecked = widget.showCheckbox && widget.isChecked?.call(item) == true;
    final trailing = widget.trailingBuilder?.call(item);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onItemSelected(item),
        child: Container(
          height: widget.itemHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              if (widget.showCheckbox)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(
                    isChecked ? Icons.check_circle : Icons.circle_outlined,
                    color: isChecked ? theme.colorScheme.primary : theme.dividerColor,
                  ),
                ),
              Expanded(
                child: DefaultTextStyle(
                  style: widget.itemTextStyle ?? theme.textTheme.bodyLarge!,
                  child: widget.itemBuilder(item),
                ),
              ),
              if (hasActions) _buildActionButtons(context, item, index),
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, T item, int index) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.onEdit != null)
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: () => widget.onEdit!(item, index),
            color: theme.colorScheme.primary,
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          ),
        if (widget.onDelete != null)
          IconButton(
            icon: const Icon(Icons.delete, size: 20),
            onPressed: () => widget.onDelete!(item, index),
            color: theme.colorScheme.error,
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          ),
      ],
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    Widget? customWidget, {
    String message = 'No data available',
  }) {
    final theme = Theme.of(context);

    if (customWidget != null) {
      return SizedBox(
        height: 300,
        child: Center(child: customWidget),
      );
    }

    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isSearching ? Icons.search_off : Icons.inbox_outlined,
              size: 48,
              color: theme.disabledColor,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.disabledColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
