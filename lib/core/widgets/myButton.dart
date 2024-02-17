import 'package:flutter/material.dart';
import 'package:moon/core/theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 90,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: primaryClr),
          child: Text(
            label,
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
