import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../screens/desktop/about.dart' as desktop;
import '../../screens/mobile/therapy.dart' as mobile;
import '../../screens/tablet/about.dart' as tablet;

class AboutController extends StatefulController {
  final String _title = 'Quản lý trị liệu';
  const AboutController({Key? key}) : super(key: key);

  @override
  State<AboutController> createState() => _AboutControllerState();
}

class _AboutControllerState extends ControllerState<AboutController> {
  @override
  bool get auth => true;

  @override
  Display view(BuildContext context) {
    return Display(
      title: widget._title,
      mobile: mobile.About(
        title: widget._title,
      ),
      tabletLandscape: tablet.About(title: widget._title),
      desktop: desktop.About(title: widget._title),
    );
  }
}
