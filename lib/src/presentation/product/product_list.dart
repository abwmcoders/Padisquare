import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widget/custom_bottom_bar.dart';
import 'product_initial.dart';


class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  ProductListScreenState createState() => ProductListScreenState();
}

class ProductListScreenState extends State<ProductListScreen> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  int currentIndex = 0;

  final List<String> routes = ['/product-list-screen', '/saved-products-screen', '/categories-screen', '/profile-screen'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: navigatorKey,
        initialRoute: '/product-list-screen',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/product-list-screen':
            case '/':
              return MaterialPageRoute(builder: (context) => const ProductListScreenInitialPage(), settings: settings);
            default:
              if (AppRoutes.routes.containsKey(settings.name)) {
                return MaterialPageRoute(builder: AppRoutes.routes[settings.name]!, settings: settings);
              }
              return null;
          }
        },
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (!AppRoutes.routes.containsKey(routes[index])) {
            return;
          }
          if (currentIndex != index) {
            setState(() => currentIndex = index);
            navigatorKey.currentState?.pushReplacementNamed(routes[index]);
          }
        },
      ),
    );
  }
}


