import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widget/custom_icon_widget.dart';



class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final VoidCallback onFilterTap;
  final VoidCallback onSortTap;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onFilterTap,
    required this.onSortTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.08),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.colorScheme.outline,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: controller,
                    onChanged: onSearch,
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: CustomIconWidget(
                          iconName: 'search',
                          size: 5.w,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      suffixIcon: controller.text.isNotEmpty
                          ? IconButton(
                              icon: CustomIconWidget(
                                iconName: 'clear',
                                size: 5.w,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              onPressed: () {
                                controller.clear();
                                onSearch('');
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 1.5.h,
                      ),
                    ),
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              InkWell(
                onTap: onFilterTap,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 6.h,
                  width: 6.h,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: 'filter_list',
                      size: 5.w,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              InkWell(
                onTap: onSortTap,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 6.h,
                  width: 6.h,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: 'sort',
                      size: 5.w,
                      color: theme.colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


