import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductDescriptionWidget extends StatefulWidget {
  final String description;

  const ProductDescriptionWidget({super.key, required this.description});

  @override
  State<ProductDescriptionWidget> createState() => _ProductDescriptionWidgetState();
}

class _ProductDescriptionWidgetState extends State<ProductDescriptionWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),

          SizedBox(height: 1.h),

          Text(
            widget.description,
            style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.5),
            maxLines: _isExpanded ? null : 4,
            overflow: _isExpanded ? null : TextOverflow.ellipsis,
          ),

          widget.description.length > 200
              ? Column(
                  children: [
                    SizedBox(height: 1.h),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _isExpanded ? 'Show less' : 'Read more',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 1.w),
                          Icon(
                            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: theme.colorScheme.primary,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

