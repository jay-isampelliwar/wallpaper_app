import 'package:flutter/material.dart';
import 'package:wallpaper_app/features/display/ui/display.dart';
import 'package:wallpaper_app/utils/routes/routes_name.dart';

import '../../features/home/ui/home_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) {
          return const HomePage();
        });
      case RoutesName.display:
        return MaterialPageRoute(builder: (context) {
          Map<String, String> map = settings.arguments as Map<String, String>;
          String? url = map["url"];
          String? tag = map["tag"];
          return Display(imageUrl: url!, tag: tag!);
        });
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text("No Routes Found"),
              ),
            );
          },
        );
    }
  }
}
