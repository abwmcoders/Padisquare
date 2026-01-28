import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../routes/app_routes.dart';
import '../../services/saved_product_service.dart';
import '../../widget/custom_icon_widget.dart';
import '../product/widget/product_card_widget.dart';


class SavedProductsScreen extends StatefulWidget {
  const SavedProductsScreen({super.key});

  @override
  State<SavedProductsScreen> createState() => _SavedProductsScreenState();
}

class _SavedProductsScreenState extends State<SavedProductsScreen> {
  SavedProductsService? _savedProductsService;
  List<int> _savedProductIds = [];
  bool _isLoading = true;

  final List<Map<String, dynamic>> _allProducts = [
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

  @override
  void initState() {
    super.initState();
    _initService();
  }

  Future<void> _initService() async {
    _savedProductsService = await SavedProductsService.getInstance();
    await _loadSavedProducts();
  }

  Future<void> _loadSavedProducts() async {
    if (_savedProductsService == null) return;
    setState(() => _isLoading = true);
    final savedIds = await _savedProductsService!.getSavedProductIds();
    setState(() {
      _savedProductIds = savedIds;
      _isLoading = false;
    });
  }

  List<Map<String, dynamic>> get _savedProducts {
    return _allProducts.where((product) => _savedProductIds.contains(product['id'] as int)).toList();
  }

  Future<void> _handleUnsave(int productId) async {
    if (_savedProductsService == null) return;
    await _savedProductsService!.unsaveProduct(productId);
    await _loadSavedProducts();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Saved Products',
          style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onSurface, fontWeight: FontWeight.w600),
        ),
        actions: [
          if (_savedProducts.isNotEmpty)
            IconButton(
              icon: CustomIconWidget(iconName: 'delete_outline', size: 6.w, color: theme.colorScheme.error),
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear All'),
                    content: const Text('Are you sure you want to remove all saved products?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text('Clear', style: TextStyle(color: theme.colorScheme.error)),
                      ),
                    ],
                  ),
                );
                if (confirmed == true && _savedProductsService != null) {
                  await _savedProductsService!.clearAllSavedProducts();
                  await _loadSavedProducts();
                }
              },
            ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: theme.colorScheme.primary,),)
          : _savedProducts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(iconName: 'bookmark_border', size: 20.w, color: theme.colorScheme.onSurfaceVariant),
                  SizedBox(height: 2.h),
                  Text(
                    'No Saved Products',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      'Products you save will appear here for easy access',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadSavedProducts,
              child: GridView.builder(
                padding: EdgeInsets.all(4.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 3.w,
                  mainAxisSpacing: 2.h,
                  childAspectRatio: 0.7,
                ),
                itemCount: _savedProducts.length,
                itemBuilder: (context, index) {
                  final product = _savedProducts[index];
                  return Stack(
                    children: [
                      ProductCardWidget(
                        product: product,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.productDetails, arguments: product);
                        },
                        onSaveChanged: _loadSavedProducts,
                      ),
                      Positioned(
                        top: 1.h,
                        right: 2.w,
                        child: InkWell(
                          onTap: () => _handleUnsave(product['id'] as int),
                          child: Container(
                            padding: EdgeInsets.all(1.5.w),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.error,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: theme.shadowColor.withValues(alpha: 0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: CustomIconWidget(iconName: 'bookmark', size: 5.w, color: theme.colorScheme.onError),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}


