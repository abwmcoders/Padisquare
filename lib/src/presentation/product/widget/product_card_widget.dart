import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../services/saved_product_service.dart';
import '../../../widget/custom_icon_widget.dart';
import '../../../widget/custom_image_widget.dart';


class ProductCardWidget extends StatefulWidget {
  final Map<String, dynamic> product;
  final VoidCallback onTap;
  final VoidCallback? onSaveChanged;

  const ProductCardWidget({
    super.key,
    required this.product,
    required this.onTap,
    this.onSaveChanged,
  });

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  bool _isSaved = false;
  bool _isLoading = false;
  SavedProductsService? _savedProductsService;

  @override
  void initState() {
    super.initState();
    _initService();
  }

  Future<void> _initService() async {
    _savedProductsService = await SavedProductsService.getInstance();
    await _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    if (_savedProductsService != null) {
      final isSaved = await _savedProductsService!.isProductSaved(
        widget.product['id'] as int,
      );
      if (mounted) {
        setState(() => _isSaved = isSaved);
      }
    }
  }

  Future<void> _toggleSave() async {
    if (_savedProductsService == null || _isLoading) return;

    setState(() => _isLoading = true);
    await _savedProductsService!.toggleSaveProduct(widget.product['id'] as int);
    await _checkIfSaved();
    setState(() => _isLoading = false);
    widget.onSaveChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.08),
              offset: const Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: CustomImageWidget(
                    imageUrl: widget.product['image'] as String,
                    width: double.infinity,
                    height: 20.h,
                    fit: BoxFit.cover,
                    semanticLabel: widget.product['semanticLabel'] as String,
                  ),
                ),
                Positioned(
                  top: 1.h,
                  left: 2.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      widget.product['vendor'] as String,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 1.h,
                  right: 2.w,
                  child: InkWell(
                    onTap: _toggleSave,
                    child: Container(
                      padding: EdgeInsets.all(1.5.w),
                      decoration: BoxDecoration(
                        color: _isSaved
                            ? theme.colorScheme.primary
                            : theme.cardColor.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: theme.shadowColor.withValues(alpha: 0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: _isLoading
                          ? SizedBox(
                              width: 5.w,
                              height: 5.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: theme.colorScheme.primary,
                              ),
                            )
                          : CustomIconWidget(
                              iconName: _isSaved
                                  ? 'bookmark'
                                  : 'bookmark_border',
                              size: 5.w,
                              color: _isSaved
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.onSurface,
                            ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(1.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product['name'] as String,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 0.5.h),
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'star',
                              size: 3.5.w,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              '${widget.product['rating']}',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              '(${widget.product['reviews']})',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      '${widget.product['currency']}${widget.product['price']}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

