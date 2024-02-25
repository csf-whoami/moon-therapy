import 'package:moon/core/classes/classes.dart';
import 'package:moon/features/auth_mod/auth_app.dart';
import 'package:moon/features/main_app/app.dart';

class Routes extends RouteManager {
  Routes() {
    addAll(AuthApp().routes);
    // addAll(LeadApp().routes);
    addAll(App().routes);
    // addAll(FeatureApp().routes);
  }
}
