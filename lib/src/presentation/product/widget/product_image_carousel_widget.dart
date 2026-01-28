import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widget/custom_icon_widget.dart';
import '../../../widget/custom_image_widget.dart';


class ProductImageCarouselWidget extends StatefulWidget {
  final List<String> images;
  final String productName;

  const ProductImageCarouselWidget({
    super.key,
    required this.images,
    required this.productName,
  });

  @override
  State<ProductImageCarouselWidget> createState() =>
      _ProductImageCarouselWidgetState();
}

class _ProductImageCarouselWidgetState
    extends State<ProductImageCarouselWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final TransformationController _transformationController =
      TransformationController();

  @override
  void dispose() {
    _pageController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 45.h,
      width: double.infinity,
      color: theme.colorScheme.surface,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return InteractiveViewer(
                transformationController: _transformationController,
                minScale: 1.0,
                maxScale: 3.0,
                child: Center(
                  child: Hero(
                    tag: 'product_image_${widget.productName}',
                    child: CustomImageWidget(
                      imageUrl: widget.images[index],
                      width: double.infinity,
                      height: 45.h,
                      fit: BoxFit.contain,
                      semanticLabel:
                          "Product image ${index + 1} of ${widget.images.length} showing ${widget.productName}",
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 2.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 0.5.w),
                  width: _currentPage == index ? 8.w : 2.w,
                  height: 1.h,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant.withValues(
                            alpha: 0.3,
                          ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 2.h,
            right: 4.w,
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: CustomIconWidget(
                  iconName: 'fullscreen',
                  color: theme.colorScheme.onSurface,
                  size: 24,
                ),
                onPressed: () {
                  _showFullScreenGallery(context);
                },
                tooltip: 'View full screen',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFullScreenGallery(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _FullScreenGallery(
          images: widget.images,
          initialPage: _currentPage,
          productName: widget.productName,
        ),
      ),
    );
  }
}
class _FullScreenGallery extends StatefulWidget {
  final List<String> images;
  final int initialPage;
  final String productName;

  const _FullScreenGallery({
    required this.images,
    required this.initialPage,
    required this.productName,
  });

  @override
  State<_FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<_FullScreenGallery> {
  late PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return InteractiveViewer(
                minScale: 1.0,
                maxScale: 4.0,
                child: Center(
                  child: CustomImageWidget(
                    imageUrl: widget.images[index],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.contain,
                    semanticLabel:
                        "Full screen view of product image ${index + 1} showing ${widget.productName}",
                  ),
                ),
              );
            },
          ),
          SafeArea(
            child: Positioned(
              top: 2.h,
              left: 4.w,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Close',
                ),
              ),
            ),
          ),
          SafeArea(
            child: Positioned(
              top: 2.h,
              right: 4.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${_currentPage + 1} / ${widget.images.length}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


