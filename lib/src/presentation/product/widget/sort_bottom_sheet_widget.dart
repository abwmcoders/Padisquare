import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widget/custom_icon_widget.dart';



class SortBottomSheetWidget extends StatelessWidget {
  final String currentSort;
  final Function(String) onSelect;

  const SortBottomSheetWidget({super.key, required this.currentSort, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final sortOptions = [
      {'value': 'relevance', 'label': 'Relevance', 'icon': 'trending_up'},
      {'value': 'price_low', 'label': 'Price: Low to High', 'icon': 'arrow_upward'},
      {'value': 'price_high', 'label': 'Price: High to Low', 'icon': 'arrow_downward'},
      {'value': 'rating', 'label': 'Highest Rated', 'icon': 'star'},
      {'value': 'newest', 'label': 'Newest First', 'icon': 'new_releases'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: theme.colorScheme.outline, width: 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sort By',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: CustomIconWidget(iconName: 'close', size: 6.w, color: theme.colorScheme.onSurface),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sortOptions.length,
              itemBuilder: (context, index) {
                final option = sortOptions[index];
                final isSelected = currentSort == option['value'];

                return ListTile(
                  leading: CustomIconWidget(
                    iconName: option['icon'] as String,
                    size: 6.w,
                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                  ),
                  title: Text(
                    option['label'] as String,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  trailing: isSelected
                      ? CustomIconWidget(iconName: 'check_circle', size: 6.w, color: theme.colorScheme.primary)
                      : null,
                  onTap: () {
                    onSelect(option['value'] as String);
                    Navigator.pop(context);
                  },
                );
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}


