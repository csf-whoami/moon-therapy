import 'package:flutter/material.dart';
import 'package:moon/core/widgets/bottom_bar.dart';

class TherapyController extends StatelessWidget {
  const TherapyController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature 2 about'),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
