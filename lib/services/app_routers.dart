import 'package:blogger/model/blog_model.dart';
import 'package:blogger/screens/blog_description_screen.dart';
import 'package:blogger/screens/favorite_screen.dart';
import 'package:flutter/material.dart';

import '../screens/landing_screen.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case LandingScreen.route:
        return MaterialPageRoute(builder: (_) => const LandingScreen());

      case FavoriteScreen.route:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());

      case BlogDescriptionScreen.route:
        if (args is BlogModel) {
          return MaterialPageRoute(
            builder: (_) => BlogDescriptionScreen(blogModel: args),
          );
        }
        break;

      default:
        return _errorRoute();
    }
    return null;
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: const Center(child: Text("ERROR")),
      );
    },
  );
}
