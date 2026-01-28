import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final double elevation;
  final Color? backgroundColor;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final Widget? titleWidget;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.elevation = 0,
    this.backgroundColor,
    this.centerTitle = false,
    this.bottom,
    this.titleWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canPop = Navigator.of(context).canPop();

    return AppBar(
      title: titleWidget ?? Text(title, style: theme.appBarTheme.titleTextStyle),
      leading:
          leading ??
          (automaticallyImplyLeading && canPop
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Back',
                  splashRadius: 24,
                )
              : null),
      actions: actions,
      backgroundColor: backgroundColor ?? theme.appBarTheme.backgroundColor,
      foregroundColor: theme.appBarTheme.foregroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      bottom: bottom,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: theme.brightness == Brightness.light ? Brightness.dark : Brightness.light,
        statusBarBrightness: theme.brightness,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}

class CustomSearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String searchHint;
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String>? onSearchSubmitted;
  final String? initialQuery;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const CustomSearchAppBar({
    super.key,
    this.searchHint = 'Search products...',
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.initialQuery,
    this.actions,
    this.backgroundColor,
  });

  @override
  State<CustomSearchAppBar> createState() => _CustomSearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomSearchAppBarState extends State<CustomSearchAppBar> {
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
    _searchFocusNode = FocusNode();

    _searchController.addListener(() {
      widget.onSearchChanged?.call(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
    _searchFocusNode.requestFocus();
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
    _searchFocusNode.unfocus();
    widget.onSearchChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: widget.backgroundColor ?? theme.appBarTheme.backgroundColor,
      foregroundColor: theme.appBarTheme.foregroundColor,
      elevation: 0,
      leading: _isSearching
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: _stopSearch,
              tooltip: 'Cancel search',
              splashRadius: 24,
            )
          : null,
      title: _isSearching
          ? TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              decoration: InputDecoration(
                hintText: widget.searchHint,
                border: InputBorder.none,
                hintStyle: theme.inputDecorationTheme.hintStyle,
              ),
              style: theme.textTheme.bodyLarge,
              textInputAction: TextInputAction.search,
              onSubmitted: widget.onSearchSubmitted,
            )
          : Text('Products', style: theme.appBarTheme.titleTextStyle),
      actions: _isSearching
          ? [
              if (_searchController.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    widget.onSearchChanged?.call('');
                  },
                  tooltip: 'Clear search',
                  splashRadius: 24,
                ),
            ]
          : [
              IconButton(icon: const Icon(Icons.search), onPressed: _startSearch, tooltip: 'Search', splashRadius: 24),
              if (widget.actions != null) ...widget.actions!,
            ],
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: theme.brightness == Brightness.light ? Brightness.dark : Brightness.light,
        statusBarBrightness: theme.brightness,
      ),
    );
  }
}

