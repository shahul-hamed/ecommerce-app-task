import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final ButtonStyle style;
  const MyElevatedButton({Key? key, required this.child, required this.onPressed, required this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, style: style, child: child,);
  }
}
