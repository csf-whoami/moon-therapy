import 'package:flutter/material.dart';
import 'package:moon/features/main_app/Screens/mobile/home.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _index = 0;
  List pages = const [
    Home(),
    Home(),
    Home(),
    Home(),
  ];

  @override
  void initState() {
    super.initState();
    var tm = context.read<ThemeProvider>();
    _index = tm.index;
  }

  @override
  Widget build(BuildContext context) {
    var tm = context.read<ThemeProvider>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 25,
          offset: const Offset(8, 20),
        ),
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          items: [
            bottomNavigationBarItem(icon: const Icon(Icons.home), label: 'Home'),
            bottomNavigationBarItem(icon: const Icon(Icons.people), label: 'About'),
            bottomNavigationBarItem(icon: const Icon(Icons.contact_mail), label: 'Contact'),
            bottomNavigationBarItem(icon: const Icon(Icons.newspaper), label: 'News'),
            bottomNavigationBarItem(icon: const Icon(Icons.ac_unit), label: 'Feature'),
          ],
          backgroundColor: Colors.white,
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          currentIndex: _index,
          onTap: (val) {
            tm.setNavIndex(val);
            setState(() {
              _index = val;
              navigator();
            });
          },
        ),
      ),
    );

    // TODO: Curved Navigation Bar
    // return CurvedNavigationBar(
    //   color: Colors.deepPurple.shade200,
    //   backgroundColor: Colors.deepPurple,
    //   animationDuration: Duration(milliseconds: 300),
    //   onTap: (index) {
    //     print("Item $index");
    //   },
    //   items: [
    //     Icon(
    //       Icons.home,
    //       color: Colors.white,
    //     ),
    //     Icon(Icons.favorite),
    //     Icon(Icons.settings),
    //   ],
    // );

    // TODO: Original Navigation Bar
    // return BottomNavigationBar(
    //     type: BottomNavigationBarType.fixed,
    //     currentIndex: index,
    //     onTap: (val) {
    //       tm.setNavIndex(val);
    //       setState(() {
    //         index = val;
    //         navigator();
    //       });
    //     },
    //     items: [
    //       bottomNavigationBarItem(icon: const Icon(Icons.home), label: 'Home'),
    //       bottomNavigationBarItem(
    //           icon: const Icon(Icons.people), label: 'About'),
    //       bottomNavigationBarItem(
    //           icon: const Icon(Icons.contact_mail), label: 'Contact'),
    //       bottomNavigationBarItem(
    //           icon: const Icon(Icons.newspaper), label: 'News'),
    //       bottomNavigationBarItem(
    //           icon: const Icon(Icons.ac_unit), label: 'Feature'),
    //     ]);
  }

  void navigator() {
    switch (_index) {
      case 0:
        Nav.to(context, '/');
        break;
      case 1:
        Nav.to(context, '/about');
        break;
      case 2:
        Nav.to(context, '/order');
        break;
      case 3:
        Nav.to(context, '/news');
        break;
      case 4:
        Nav.to(context, '/feature');
        break;
      default:
    }
  }
}
