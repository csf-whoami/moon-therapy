import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class CreateOrderController extends StatelessWidget {
  const CreateOrderController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature 2 contact'),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
