import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social/features/create_post/presentation/pages/create_post_screen.dart';
import 'package:social/features/feeds/presentation/pages/feeds_page.dart';
import 'package:social/features/login/presentation/pages/login_page.dart';

import '../features/splash/presentation/pages/splash_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String feeds = '/feeds';
  static const String createFeed = '/create_feed';
}

Route _buildPageRoute(Widget child, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fade = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
      final offset = Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
      return FadeTransition(
        opacity: fade,
        child: SlideTransition(position: offset, child: child),
      );
    },
  );
}

RouteFactory generateRoute = (RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return _buildPageRoute(const SplashPage(), settings);

    case AppRoutes.login:
      return _buildPageRoute(const LoginScreen(), settings);

    case AppRoutes.feeds:
      return _buildPageRoute(const FeedsScreen(), settings);

    case AppRoutes.createFeed:
      return _buildPageRoute(CreatePostScreen(), settings);

    default:
      return _buildPageRoute(const SplashPage(), settings);
  }
};
