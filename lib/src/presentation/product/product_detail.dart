import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../widget/custom_app_bar.dart';
import '../../widget/custom_icon_widget.dart';
import 'widget/product_description_widget.dart';
import 'widget/product_image_carousel_widget.dart';
import 'widget/product_info_header_widget.dart';
import 'widget/product_specifications_widget.dart';
import 'widget/vendor_info_card_widget.dart';



class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showStickyHeader = false;
  bool _isLoading = false;
  bool _isSaved = false;
  String? _lastUpdated;

  // Mock product data
  final Map<String, dynamic> _productData = {
    "id": 1,
    "name": "Premium Wireless Headphones",
    "price": "\$299.99",
    "rating": 4.8,
    "description":
        "Experience superior sound quality with our Premium Wireless Headphones. Featuring advanced noise cancellation technology, these headphones deliver crystal-clear audio whether you're listening to music, taking calls, or enjoying podcasts. The ergonomic design ensures all-day comfort, while the long-lasting battery provides up to 30 hours of continuous playback. With Bluetooth 5.0 connectivity, you can seamlessly connect to all your devices. The premium materials and craftsmanship make these headphones a perfect blend of style and functionality.",
    "images": [
      "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800",
      "https://images.unsplash.com/photo-1484704849700-f032a568e944?w=800",
      "https://images.unsplash.com/photo-1487215078519-e21cc028cb29?w=800",
    ],
    "imageSemanticLabels": [
      "Black wireless over-ear headphones with metallic accents on white background",
      "Side view of premium headphones showing cushioned ear cups and adjustable headband",
      "Close-up of headphone controls and premium leather finish details",
    ],
    "specifications": {
      "Brand": "AudioTech Pro",
      "Model": "AT-WH3000",
      "Color": "Midnight Black",
      "Connectivity": "Bluetooth 5.0",
      "Battery Life": "30 hours",
      "Charging Time": "2 hours",
      "Weight": "250g",
      "Warranty": "2 years",
    },
    "vendor": {
      "name": "TechGear Solutions",
      "logo": "https://ui-avatars.com/api/?name=TechGear+Solutions&background=3498DB&color=fff&size=200",
      "logoSemanticLabel": "TechGear Solutions company logo with blue background and white text initials",
      "rating": 4.7,
      "location": "San Francisco, CA",
      "totalProducts": 156,
    },
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadProductDetails();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 200 && !_showStickyHeader) {
      setState(() {
        _showStickyHeader = true;
      });
    } else if (_scrollController.offset <= 200 && _showStickyHeader) {
      setState(() {
        _showStickyHeader = false;
      });
    }
  }

  Future<void> _loadProductDetails() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 800));

    setState(() {
      _isLoading = false;
      _lastUpdated = DateTime.now().toString().substring(0, 19);
    });
  }

  Future<void> _refreshProductDetails() async {
    await _loadProductDetails();
  }

  void _toggleSaveProduct() {
    setState(() {
      _isSaved = !_isSaved;
    });

    HapticFeedback.lightImpact();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isSaved ? 'Product saved' : 'Product removed from saved'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _shareProduct() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Share functionality would open native share sheet'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _contactVendor() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => _ContactVendorSheet(vendorName: _productData["vendor"]["name"] as String),
    );
  }

  void _viewAllVendorProducts() {
    Navigator.of(context, rootNavigator: true).pushNamed('/product-list-screen');
  }

  void _showVendorContextMenu() {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CustomIconWidget(iconName: 'phone', color: theme.colorScheme.primary, size: 24),
              title: Text('Call Vendor'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Would open phone dialer'), duration: Duration(seconds: 2)),
                );
              },
            ),
            ListTile(
              leading: CustomIconWidget(iconName: 'email', color: theme.colorScheme.primary, size: 24),
              title: Text('Email Vendor'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Would open email client'), duration: Duration(seconds: 2)),
                );
              },
            ),
            ListTile(
              leading: CustomIconWidget(iconName: 'location_on', color: theme.colorScheme.primary, size: 24),
              title: Text('View Location'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Would open maps application'), duration: Duration(seconds: 2)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: _showStickyHeader ? _productData["name"] as String : '',
        leading: IconButton(
          icon: CustomIconWidget(iconName: 'arrow_back', color: theme.colorScheme.onSurface, size: 24),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
        ),
        actions: [
          IconButton(
            icon: CustomIconWidget(iconName: 'share', color: theme.colorScheme.onSurface, size: 24),
            onPressed: _shareProduct,
            tooltip: 'Share',
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: _isLoading ? _buildLoadingState() : _buildContent(),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildLoadingState() {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(height: 45.h, width: double.infinity, color: theme.colorScheme.surfaceContainerHighest),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 3.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 1.h),
                Container(
                  height: 2.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 2.h),
                ...List.generate(
                  3,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 1.h),
                    child: Container(
                      height: 1.5.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return RefreshIndicator(
      onRefresh: _refreshProductDetails,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ProductImageCarouselWidget(
              images: (_productData["images"] as List).cast<String>(),
              productName: _productData["name"] as String,
            ),
          ),
          _showStickyHeader
              ? SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyHeaderDelegate(
                    child: ProductInfoHeaderWidget(
                      productName: _productData["name"] as String,
                      price: _productData["price"] as String,
                      vendorLogo: _productData["vendor"]["logo"] as String,
                      vendorName: _productData["vendor"]["name"] as String,
                      rating: (_productData["rating"] as num).toDouble(),
                      hide: !_showStickyHeader,
                    ),
                  ),
                )
              : const SliverToBoxAdapter(child: SizedBox.shrink()),
          !_showStickyHeader
              ? SliverToBoxAdapter(
                  child: ProductInfoHeaderWidget(
                    productName: _productData["name"] as String,
                    price: _productData["price"] as String,
                    vendorLogo: _productData["vendor"]["logo"] as String,
                    vendorName: _productData["vendor"]["name"] as String,
                    rating: (_productData["rating"] as num).toDouble(),
                    hide: !_showStickyHeader,
                  ),
                )
              : const SliverToBoxAdapter(child: SizedBox.shrink()),
          SliverToBoxAdapter(child: ProductDescriptionWidget(description: _productData["description"] as String)),
          SliverToBoxAdapter(
            child: ProductSpecificationsWidget(
              specifications: (_productData["specifications"] as Map<String, dynamic>).cast<String, String>(),
            ),
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              onLongPress: _showVendorContextMenu,
              child: VendorInfoCardWidget(
                vendorName: _productData["vendor"]["name"] as String,
                vendorLogo: _productData["vendor"]["logo"] as String,
                rating: (_productData["vendor"]["rating"] as num).toDouble(),
                location: _productData["vendor"]["location"] as String,
                totalProducts: _productData["vendor"]["totalProducts"] as int,
                onViewAllProducts: _viewAllVendorProducts,
                onContactVendor: _contactVendor,
              ),
            ),
          ),
          _lastUpdated != null
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    child: Text(
                      'Last updated: $_lastUpdated',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : const SliverToBoxAdapter(child: SizedBox.shrink()),
          SliverToBoxAdapter(child: SizedBox(height: 2.h)),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.08),
            offset: const Offset(0, -2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.outline, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: CustomIconWidget(
                  iconName: _isSaved ? 'bookmark' : 'bookmark_border',
                  color: _isSaved ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                  size: 24,
                ),
                onPressed: _toggleSaveProduct,
                tooltip: _isSaved ? 'Remove from saved' : 'Save product',
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: ElevatedButton(
                onPressed: _contactVendor,
                style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 1.8.h)),
                child: Text('Contact Vendor'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _StickyHeaderDelegate({required this.child});
  @override
  double get minExtent => 12.h;

  @override
  double get maxExtent => 12.h;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }
  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return false;
  }
}

class _ContactVendorSheet extends StatelessWidget {
  final String vendorName;

  const _ContactVendorSheet({required this.vendorName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(height: 2.h),
          Text('Contact $vendorName', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: 3.h),
          ListTile(
            leading: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(iconName: 'phone', color: theme.colorScheme.surface, size: 24),
            ),
            title: Text('Call Vendor'),
            subtitle: Text('Opens phone dialer'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Would open phone dialer with vendor number'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          ListTile(
            leading: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(iconName: 'email', color: theme.colorScheme.surface, size: 24),
            ),
            title: Text('Email Vendor'),
            subtitle: Text('Opens email client'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Would open email client with vendor email'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}


