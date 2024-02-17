import '../../core/classes/route_manager.dart';
import 'controllers/controller.dart';

class FeatureApp extends RouteManager {
  static const String name = '/feature';
  static const String home = FeatureApp.name;
  static const String therapy = '${FeatureApp.name}/therapy';
  static const String order = '${FeatureApp.name}/order';

  FeatureApp() {
    addRoute(FeatureApp.home, (context) => const HomeController());
    addRoute(FeatureApp.therapy, (context) => const TherapyController());
    addRoute(FeatureApp.order, (context) => const CreateOrderController());
  }
}
