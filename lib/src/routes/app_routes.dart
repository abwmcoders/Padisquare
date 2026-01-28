import 'package:flutter/material.dart';
import '../presentation/product/product_detail.dart';
import '../presentation/product/product_list.dart';
import '../presentation/saved/saved_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';


class AppRoutes {
  static const String initial = '/';
  static const String productDetails = '/product-details-screen';
  static const String splash = '/splash-screen';
  static const String productList = '/product-list-screen';
  static const String savedProducts = '/saved-products-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    productDetails: (context) => const ProductDetailsScreen(),
    splash: (context) => const SplashScreen(),
    productList: (context) => const ProductListScreen(),
    savedProducts: (context) => const SavedProductsScreen(),
  };
}

