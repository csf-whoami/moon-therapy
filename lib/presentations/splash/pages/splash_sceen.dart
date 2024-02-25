import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCreen extends StatefulWidget {
  const SplashCreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashCreenState();
}

class _SplashCreenState extends State<SplashCreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 5), () {
      // Nav.to(context, '/');
      // print('Move to another page');
      fetchSomething();
    });
  }

  // @override
  // void dispose() {
  //   SystemChrome.setEnabledSystemUIMode(
  //     SystemUiMode.manual,
  //     overlays: SystemUiOverlay.values,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Moon - trị liệu",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontSize: 32,
              ),
            )
          ],
        ),
      ),
    );
  }

  void fetchSomething() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _isHaveData = prefs.getString("user_data") ?? "";

    if (_isHaveData.isEmpty) {
      await prefs.setString("user_data", "just login");
      print('Move to login page');
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      print('Move to home page');
      Navigator.pushReplacementNamed(context, '/');
    }
  }
}
