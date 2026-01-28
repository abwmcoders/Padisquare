import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/app_theme.dart';
import '../../../widget/custom_icon_widget.dart';
import '../../../widget/custom_image_widget.dart';

class ProductInfoHeaderWidget extends StatelessWidget {
  final String productName;
  final String price;
  final String vendorLogo;
  final String vendorName;
  final double rating;
  final bool hide;

  const ProductInfoHeaderWidget({
    super.key,
    required this.productName,
    required this.price,
    required this.vendorLogo,
    required this.vendorName,
    required this.rating,
    required this.hide,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(bottom: BorderSide(color: theme.colorScheme.outline, width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  productName,
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),

              hide ?  Row(
                  children: [
                    Text(
                      price,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: AppTheme.successLight.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconWidget(iconName: 'star', color: AppTheme.warningLight, size: 16),
                          SizedBox(width: 1.w),
                          Text(
                            rating.toStringAsFixed(1),
                            style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ) : SizedBox.shrink(),
              ],
            ),
          ),
          SizedBox(width: 3.w),
          Container(
            padding: EdgeInsets.all(1.w),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.colorScheme.outline, width: 1),
            ),
            child: CustomImageWidget(
              imageUrl: vendorLogo,
              width: 10.w,
              height: 10.w,
              fit: BoxFit.contain,
              semanticLabel: "$vendorName company logo",
            ),
          ),
        ],
      ),
    );
  }
}
