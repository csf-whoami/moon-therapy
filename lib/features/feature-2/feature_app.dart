import '../../core/classes/route_manager.dart';
import 'controllers/controller.dart';

class FeatureApp extends RouteManager {
  static const String name = '/feature';
  static const String home = FeatureApp.name;
  static const String therapy = '${FeatureApp.name}/therapy';
  static const String contact = '${FeatureApp.name}/contact';

  FeatureApp() {
    addRoute(FeatureApp.home, (context) => const HomeController());
    addRoute(FeatureApp.therapy, (context) => const TherapyController());
    addRoute(FeatureApp.contact, (context) => const ContactController());
  }
}
