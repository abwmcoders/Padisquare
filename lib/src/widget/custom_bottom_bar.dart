import 'package:flutter/material.dart';


class CustomBottomBar extends StatelessWidget {
  final int currentIndex;

  final Function(int) onTap;

  const CustomBottomBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.bottomNavigationBarTheme.backgroundColor,
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
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,
          selectedLabelStyle: theme.bottomNavigationBarTheme.selectedLabelStyle,
          unselectedLabelStyle: theme.bottomNavigationBarTheme.unselectedLabelStyle,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            BottomNavigationBarItem(
              icon: const Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.home_outlined, size: 24)),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(Icons.home, size: 24, color: theme.bottomNavigationBarTheme.selectedItemColor),
              ),
              label: 'Home',
              tooltip: 'Browse products',
            ),
            BottomNavigationBarItem(
              icon: const Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.bookmark_border, size: 24)),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(Icons.bookmark, size: 24, color: theme.bottomNavigationBarTheme.selectedItemColor),
              ),
              label: 'Saved',
              tooltip: 'Saved products',
            ),
            BottomNavigationBarItem(
              icon: const Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.category_outlined, size: 24)),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(Icons.category, size: 24, color: theme.bottomNavigationBarTheme.selectedItemColor),
              ),
              label: 'Categories',
              tooltip: 'Browse categories',
            ),
            BottomNavigationBarItem(
              icon: const Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.person_outline, size: 24)),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Icon(Icons.person, size: 24, color: theme.bottomNavigationBarTheme.selectedItemColor),
              ),
              label: 'Profile',
              tooltip: 'View profile',
            ),
          ],
        ),
      ),
    );
  }
}

