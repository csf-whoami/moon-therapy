import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../screens/desktop/about.dart' as desktop;
import '../../screens/mobile/therapy.dart' as mobile;
import '../../screens/tablet/about.dart' as tablet;

class TherapyController extends StatefulController {
  final String _title = 'Quản lý trị liệu';
  const TherapyController({Key? key}) : super(key: key);

  @override
  State<TherapyController> createState() => _TherapyControllerState();
}

class _TherapyControllerState extends ControllerState<TherapyController> {
  @override
  bool get auth => true;

  @override
  Display view(BuildContext context) {
    return Display(
      title: widget._title,
      mobile: mobile.Therapy(
        title: widget._title,
      ),
      tabletLandscape: tablet.About(title: widget._title),
      desktop: desktop.About(title: widget._title),
    );
  }
}
