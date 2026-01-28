import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/app_theme.dart';
import '../../../widget/custom_icon_widget.dart';
import '../../../widget/custom_image_widget.dart';


class VendorInfoCardWidget extends StatelessWidget {
  final String vendorName;
  final String vendorLogo;
  final double rating;
  final String location;
  final int totalProducts;
  final VoidCallback onViewAllProducts;
  final VoidCallback onContactVendor;

  const VendorInfoCardWidget({
    super.key,
    required this.vendorName,
    required this.vendorLogo,
    required this.rating,
    required this.location,
    required this.totalProducts,
    required this.onViewAllProducts,
    required this.onContactVendor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline, width: 1),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.08),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Vendor Information', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: 2.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.colorScheme.outline, width: 1),
                ),
                child: CustomImageWidget(
                  imageUrl: vendorLogo,
                  width: 15.w,
                  height: 15.w,
                  fit: BoxFit.contain,
                  semanticLabel: "$vendorName company logo",
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vendorName,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      children: [
                        CustomIconWidget(iconName: 'star', color: AppTheme.warningLight, size: 16),
                        SizedBox(width: 1.w),
                        Text(
                          rating.toStringAsFixed(1),
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          '($totalProducts products)',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      children: [
                        CustomIconWidget(iconName: 'location_on', color: theme.colorScheme.onSurfaceVariant, size: 16),
                        SizedBox(width: 1.w),
                        Expanded(
                          child: Text(
                            location,
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onViewAllProducts,
                  style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 1.5.h)),
                  child: Text('View All Products'),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: onContactVendor,
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 1.5.h)),
                  child: Text('Contact Vendor'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

