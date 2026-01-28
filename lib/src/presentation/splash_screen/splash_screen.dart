import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widget/custom_icon_widget.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  bool _isInitializing = true;
  bool _hasError = false;
  String _errorMessage = '';
  bool _showContinueOffline = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeApp();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));

    
  }

  Future<void> _initializeApp() async {
    try {
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted && _isInitializing) {
          setState(() {
            _showContinueOffline = true;
          });
        }
      });

      await Future.wait([
        _checkNetworkConnectivity(),
        _loadCachedData(),
        _initializeAPIConfig(),
        _prepareSearchIndices(),
        Future.delayed(const Duration(seconds: 2)),
      ]);

      if (mounted) {
        _navigateToProductList();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Failed to initialize app';
          _isInitializing = false;
        });
      }
    }
  }

  Future<void> _checkNetworkConnectivity() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _loadCachedData() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<void> _initializeAPIConfig() async {
    await Future.delayed(const Duration(milliseconds: 600));
  }

  Future<void> _prepareSearchIndices() async {
    await Future.delayed(const Duration(milliseconds: 700));
  }

  void _navigateToProductList() {
    Navigator.of(context, rootNavigator: true).pushReplacementNamed('/product-list-screen');
  }

  void _retryInitialization() {
    setState(() {
      _hasError = false;
      _isInitializing = true;
      _showContinueOffline = false;
    });
    _initializeApp();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    if (!reduceMotion) {
      _animationController.forward();
    } else {
      _animationController.value = 1.0;
    }
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [theme.colorScheme.primary, theme.colorScheme.primaryContainer],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Opacity(opacity: _fadeAnimation.value, child: child),
                  );
                },
                child: _buildLogoSection(theme),
              ),

              SizedBox(height: 8.h),
              _buildStatusSection(theme),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(4.w),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 20, offset: const Offset(0, 10)),
            ],
          ),
          child: Center(
            // child: CustomIconWidget(iconName: 'shopping_bag', size: 15.w, color: theme.colorScheme.primary),
            child: CustomIconWidget(iconName: 'assets/icons/app_logo.png', size: 15.w, color: theme.colorScheme.primary),
          ),
        ),

        SizedBox(height: 3.h),

        Text(
          'Padisquare',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Discover Products, Explore Vendors',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSection(ThemeData theme) {
    if (_hasError) {
      return _buildErrorState(theme);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 8.w,
          height: 8.w,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.onPrimary),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          'Initializing...',
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary.withValues(alpha: 0.9)),
        ),
        if (_showContinueOffline) ...[
          SizedBox(height: 3.h),
          TextButton(
            onPressed: _navigateToProductList,
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.onPrimary,
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.w),
                side: BorderSide(color: theme.colorScheme.onPrimary.withValues(alpha: 0.5), width: 1),
              ),
            ),
            child: Text(
              'Continue Offline',
              style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.onPrimary),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildErrorState(ThemeData theme) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(iconName: 'error_outline', size: 12.w, color: theme.colorScheme.error),
          SizedBox(height: 2.h),
          Text(
            _errorMessage,
            style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
          ElevatedButton.icon(
            onPressed: _retryInitialization,
            icon: CustomIconWidget(iconName: 'refresh', size: 5.w, color: theme.colorScheme.onPrimary),
            label: Text('Retry', style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.onPrimary)),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.w)),
            ),
          ),
        ],
      ),
    );
  }
}
