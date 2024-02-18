import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../screens/desktop/contact.dart' as desktop;
import '../../screens/mobile/order.dart' as mobile;
import '../../screens/tablet/contact.dart' as tablet;

class OrderController extends StatelessController {
  final String _title = 'Tạo yêu cầu';
  const OrderController({Key? key}) : super(key: key);

  @override
  bool get auth => false;

  @override
  Display view(BuildContext context) {
    return Display(
      title: _title,
      mobile: mobile.Order(
        title: _title,
      ),
      tabletLandscape: tablet.Contact(title: _title),
      desktop: desktop.Contact(title: _title),
    );
  }
}
