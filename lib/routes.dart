import 'package:flutter/material.dart';
import '/components/components.dart';
import 'start_page.dart';
import 'index.dart';

class AppRouter {

  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => StartPage(),
    '/index': (context) => IndexPage(),
  };

  static final String initialRoute = '/';

  static final RouteFactory unknownRoute = (settings) {
    return MaterialPageRoute(
        builder: (_) => const PageError(msg: '路由找不到')
    );
  };

}