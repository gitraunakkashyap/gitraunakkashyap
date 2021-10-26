import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final GestureTapCallback onTap;
  final Widget child;
  final Color backgroundColor;
  final Color outline;

  const Button(
      {Key? key,
        required this.onTap,
        required this.child,
        this.backgroundColor = Colors.white,
        this.outline = Colors.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        color: outline,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            color: backgroundColor,
          ),
          child: child,
          /*child: Text(
            "Continue with Linkdin",
            style: GoogleFonts.raleway(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: appColor,
            ),
          ),*/
        ),
      ),
    );
  }
}

