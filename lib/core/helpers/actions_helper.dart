import 'package:flutter/material.dart';

import '../core.dart';

List<Widget> actionsMenu(BuildContext context) {
  return [
    IconButton(
        onPressed: () {
          Nav.to(context, '/profile');
        },
        icon: const Icon(Icons.account_circle_outlined)),
    const DayNightSwitch(),
    // IconButton(
    //   onPressed: () {
    //     doLogout(context);
    //   },
    //   icon: const Icon(Icons.logout),
    // ),
    SizedBox(
      width: 20,
    )
    // TODO: Right icon
    // ActionTopButtons()
  ];
}
