import 'package:flutter/material.dart';
import 'package:moon/core/widgets/bottom_bar.dart';

class HomeController extends StatelessWidget {
  const HomeController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature 2 Home'),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
