import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widget/custom_icon_widget.dart';
import 'widget/filter_bottom_sheet_widget.dart';
import 'widget/product_card_widget.dart';
import 'widget/search_bar_widget.dart';
import 'widget/sort_bottom_sheet_widget.dart';



class ProductListScreenInitialPage extends StatefulWidget {
  const ProductListScreenInitialPage({super.key});

  @override
  State<ProductListScreenInitialPage> createState() => _ProductListScreenInitialPageState();
}

class _ProductListScreenInitialPageState extends State<ProductListScreenInitialPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = false;
  bool _isLoadingMore = false;
  String _searchQuery = '';
  List<String> _selectedVendors = [];
  double _minPrice = 0;
  double _maxPrice = 10000;
  List<String> _selectedCategories = [];
  String _sortBy = 'relevance';

  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _filteredProducts = [];
  int _currentPage = 1;
  final int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _loadInitialProducts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoadingMore && _filteredProducts.length < _products.length) {
        _loadMoreProducts();
      }
    }
  }

  Future<void> _loadInitialProducts() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(milliseconds: 800));

    _products = [
      {
        "id": 1,
        "name": "Premium Wireless Headphones",
        "vendor": "TechSound",
        "price": 299.99,
        "currency": "\$",
        "rating": 4.8,
        "reviews": 1247,
        "category": "Electronics",
        "image": "assets/products/wireless_headphones.png",
        "semanticLabel": "Black wireless over-ear headphones with silver accents on white background",
      },
      {
        "id": 2,
        "name": "Organic Cotton T-Shirt",
        "vendor": "EcoWear",
        "price": 34.99,
        "currency": "\$",
        "rating": 4.6,
        "reviews": 892,
        "category": "Clothing",
        "image": "https://images.unsplash.com/photo-1579675109935-a12dd235c97f",
        "semanticLabel": "White cotton t-shirt laid flat on wooden surface",
      },
      {
        "id": 3,
        "name": "Smart Fitness Watch",
        "vendor": "FitTech",
        "price": 199.99,
        "currency": "\$",
        "rating": 4.7,
        "reviews": 2156,
        "category": "Electronics",
        "image": "assets/products/smart_watch.png",
        "semanticLabel": "Silver smartwatch with black band displaying fitness metrics on screen",
      },
      {
        "id": 4,
        "name": "Leather Messenger Bag",
        "vendor": "UrbanStyle",
        "price": 149.99,
        "currency": "\$",
        "rating": 4.9,
        "reviews": 634,
        "category": "Accessories",
        "image": "https://images.unsplash.com/photo-1648465234633-2322de3766ad",
        "semanticLabel": "Brown leather messenger bag with brass buckles on wooden table",
      },
      {
        "id": 5,
        "name": "Ceramic Coffee Mug Set",
        "vendor": "HomeEssentials",
        "price": 45.99,
        "currency": "\$",
        "rating": 4.5,
        "reviews": 423,
        "category": "Home & Kitchen",
        "image": "https://images.unsplash.com/photo-1637275731582-e3043d18a8cb",
        "semanticLabel": "Set of four white ceramic coffee mugs arranged on marble countertop",
      },
      {
        "id": 6,
        "name": "Yoga Mat Premium",
        "vendor": "FitLife",
        "price": 79.99,
        "currency": "\$",
        "rating": 4.8,
        "reviews": 1089,
        "category": "Sports",
        "image": "https://images.unsplash.com/photo-1567281105305-11c3e4ace86b",
        "semanticLabel": "Purple yoga mat rolled up with carrying strap on wooden floor",
      },
      {
        "id": 7,
        "name": "Stainless Steel Water Bottle",
        "vendor": "HydroGear",
        "price": 29.99,
        "currency": "\$",
        "rating": 4.7,
        "reviews": 1567,
        "category": "Sports",
        "image": "assets/products/steel_water.png",
        "semanticLabel": "Silver insulated water bottle with black cap on outdoor background",
      },
      {
        "id": 8,
        "name": "Wireless Keyboard & Mouse",
        "vendor": "TechPro",
        "price": 89.99,
        "currency": "\$",
        "rating": 4.6,
        "reviews": 945,
        "category": "Electronics",
        "image": "https://images.unsplash.com/photo-1707858008522-16e97c8a5534",
        "semanticLabel": "White wireless keyboard and mouse set on minimalist desk setup",
      },
      {
        "id": 9,
        "name": "Canvas Sneakers",
        "vendor": "StreetStyle",
        "price": 64.99,
        "currency": "\$",
        "rating": 4.5,
        "reviews": 723,
        "category": "Footwear",
        "image": "https://images.unsplash.com/photo-1657194002304-ecc87a34340a",
        "semanticLabel": "White canvas sneakers with blue accents on concrete surface",
      },
      {
        "id": 10,
        "name": "Portable Bluetooth Speaker",
        "vendor": "SoundWave",
        "price": 119.99,
        "currency": "\$",
        "rating": 4.8,
        "reviews": 1834,
        "category": "Electronics",
        "image": "assets/products/bluetooth.png",
        "semanticLabel": "Compact black bluetooth speaker with mesh grille on wooden surface",
      },
      {
        "id": 11,
        "name": "Reading Glasses",
        "vendor": "VisionCare",
        "price": 49.99,
        "currency": "\$",
        "rating": 4.4,
        "reviews": 512,
        "category": "Accessories",
        "image": "https://images.unsplash.com/photo-1619194195325-835aa3f0c504",
        "semanticLabel": "Modern black-framed reading glasses on open book",
      },
      {
        "id": 12,
        "name": "Desk Lamp LED",
        "vendor": "BrightHome",
        "price": 54.99,
        "currency": "\$",
        "rating": 4.7,
        "reviews": 678,
        "category": "Home & Kitchen",
        "image": "assets/products/lamp.png",
        "semanticLabel": "Modern white LED desk lamp with adjustable arm on workspace",
      },
      {
        "id": 13,
        "name": "Backpack Travel",
        "vendor": "Wanderlust",
        "price": 129.99,
        "currency": "\$",
        "rating": 4.9,
        "reviews": 1456,
        "category": "Travel",
        "image": "assets/products/bag.png",
        "semanticLabel": "Gray travel backpack with multiple compartments on mountain trail",
      },
      {
        "id": 14,
        "name": "Plant Pot Set",
        "vendor": "GreenThumb",
        "price": 39.99,
        "currency": "\$",
        "rating": 4.6,
        "reviews": 834,
        "category": "Home & Garden",
        "image": "https://images.unsplash.com/photo-1613479136487-69cc7e73fb22",
        "semanticLabel": "Set of three white ceramic plant pots with succulents on windowsill",
      },
      {
        "id": 15,
        "name": "Running Shoes",
        "vendor": "SportMax",
        "price": 139.99,
        "currency": "\$",
        "rating": 4.8,
        "reviews": 2341,
        "category": "Footwear",
        "image": "https://images.unsplash.com/photo-1630781273776-8f79dd12eef3",
        "semanticLabel": "Red and white running shoes with mesh upper on athletic track",
      },
    ];

    setState(() {
      _isLoading = false;
      _applyFiltersAndSort();
    });
  }

  Future<void> _loadMoreProducts() async {
    if (_isLoadingMore) return;

    setState(() => _isLoadingMore = true);

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _currentPage++;
      _isLoadingMore = false;
    });
  }

  void _applyFiltersAndSort() {
    List<Map<String, dynamic>> filtered = List.from(_products);

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((product) {
        final name = (product['name'] as String).toLowerCase();
        final vendor = (product['vendor'] as String).toLowerCase();
        final query = _searchQuery.toLowerCase();
        return name.contains(query) || vendor.contains(query);
      }).toList();
    }

    if (_selectedVendors.isNotEmpty) {
      filtered = filtered.where((product) {
        return _selectedVendors.contains(product['vendor']);
      }).toList();
    }

    filtered = filtered.where((product) {
      final price = product['price'] as double;
      return price >= _minPrice && price <= _maxPrice;
    }).toList();

    if (_selectedCategories.isNotEmpty) {
      filtered = filtered.where((product) {
        return _selectedCategories.contains(product['category']);
      }).toList();
    }

    switch (_sortBy) {
      case 'price_low':
        filtered.sort((a, b) => (a['price'] as double).compareTo(b['price'] as double));
        break;
      case 'price_high':
        filtered.sort((a, b) => (b['price'] as double).compareTo(a['price'] as double));
        break;
      case 'rating':
        filtered.sort((a, b) => (b['rating'] as double).compareTo(a['rating'] as double));
        break;
      case 'newest':
        filtered = filtered.reversed.toList();
        break;
    }

    setState(() {
      _filteredProducts = filtered;
      _currentPage = 1;
    });
  }

  Future<void> _handleRefresh() async {
    await _loadInitialProducts();
  }

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query;
      _applyFiltersAndSort();
    });
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheetWidget(
        selectedVendors: _selectedVendors,
        minPrice: _minPrice,
        maxPrice: _maxPrice,
        selectedCategories: _selectedCategories,
        allVendors: _products.map((p) => p['vendor'] as String).toSet().toList(),
        allCategories: _products.map((p) => p['category'] as String).toSet().toList(),
        onApply: (vendors, min, max, categories) {
          setState(() {
            _selectedVendors = vendors;
            _minPrice = min;
            _maxPrice = max;
            _selectedCategories = categories;
            _applyFiltersAndSort();
          });
        },
      ),
    );
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SortBottomSheetWidget(
        currentSort: _sortBy,
        onSelect: (sortBy) {
          setState(() {
            _sortBy = sortBy;
            _applyFiltersAndSort();
          });
        },
      ),
    );
  }

  void _navigateToDetails(Map<String, dynamic> product) {
    Navigator.of(context, rootNavigator: true).pushNamed('/product-details-screen', arguments: product);
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SearchBarWidget(
              controller: _searchController,
              onSearch: _handleSearch,
              onFilterTap: _showFilterSheet,
              onSortTap: _showSortSheet,
            ),
            Expanded(
              child: _isLoading
                  ? _buildLoadingState(theme)
                  : _filteredProducts.isEmpty
                  ? _buildEmptyState(theme)
                  : RefreshIndicator(
                      onRefresh: _handleRefresh,
                      child: GridView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.all(3.w),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 3.w,
                          mainAxisSpacing: 3.w,
                          childAspectRatio: 0.68,
                        ),
                        itemCount: _filteredProducts.length + (_isLoadingMore ? 2 : 0),
                        itemBuilder: (context, index) {
                          if (index >= _filteredProducts.length) {
                            return _buildSkeletonCard(theme);
                          }
                          return ProductCardWidget(
                            product: _filteredProducts[index],
                            onTap: () => _navigateToDetails(_filteredProducts[index]),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(ThemeData theme) {
    return GridView.builder(
      padding: EdgeInsets.all(3.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 3.w,
        childAspectRatio: 0.68,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => _buildSkeletonCard(theme),
    );
  }

  Widget _buildSkeletonCard(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: theme.shadowColor.withValues(alpha: 0.08), offset: const Offset(0, 2), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withValues(alpha: 0.5),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 1.5.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 1.h),
                Container(
                  height: 2.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 1.h),
                Container(
                  height: 2.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(iconName: 'search_off', size: 20.w, color: theme.colorScheme.onSurfaceVariant),
            SizedBox(height: 3.h),
            Text(
              'No Products Found',
              style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.onSurface),
            ),
            SizedBox(height: 1.h),
            Text(
              'Try adjusting your filters or search terms',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.h),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _searchQuery = '';
                  _searchController.clear();
                  _selectedVendors.clear();
                  _selectedCategories.clear();
                  _minPrice = 0;
                  _maxPrice = 10000;
                  _sortBy = 'relevance';
                  _applyFiltersAndSort();
                });
              },
              child: const Text('Clear Filters'),
            ),
          ],
        ),
      ),
    );
  }
}

