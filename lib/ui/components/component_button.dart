import 'package:flutter/material.dart';

import '../../custom/custom_colors.dart';

/// This is the custom button component.
/// It is called from HNButton, because there is where all the features are configured.
/// Also, you can create a new button by calling directy to this section.

class ComponentButton extends StatelessWidget {
  final String text; // Style
  final IconData? leftIcon; // Style
  final IconData? rightIcon; // Style
  final TextStyle textStyle;
  final double radius;
  final VoidCallback? onPressed; // TODO: Lo suyo sería que no fuera nulable
  final VoidCallback? onLongPressed; // TODO: Lo suyo sería que no fuera nulable
  final bool autofocus;
  final Clip clipBehavior;
  final Color backgroundColor;
  final Color onPrimaryColor;
  final double elevation;
  final double padding;
  final BorderSide borderSide;
  final Duration? animationDuration;

  const ComponentButton(this.text,
      {Key? key,
      this.leftIcon,
      this.rightIcon,
      this.textStyle = const TextStyle(),
      this.radius = 0.0,
      this.onPressed,
      this.onLongPressed,
      this.autofocus = false,
      this.clipBehavior = Clip.none,
      this.backgroundColor = CustomColors.lightGrayColor,
      this.onPrimaryColor = CustomColors.whiteColor,
      this.elevation = 0.0,
      this.padding = 15.0,
      this.borderSide = const BorderSide(style: BorderStyle.none),
      this.animationDuration})
      : super(key: key);

  // TODO: añadir una función que calcule los márgenes de los iconos
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      autofocus: autofocus,
      onPressed: onPressed,
      onLongPress: onLongPressed,
      clipBehavior: clipBehavior,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return CustomColors.redPrimaryColor.withOpacity(0.5);
              } else if (states.contains(MaterialState.disabled)) {
                return CustomColors.grayColor;
              }
              return backgroundColor;
            },
          ),
          elevation: MaterialStateProperty.resolveWith<double>(
              (Set<MaterialState> states) => elevation),
          padding: MaterialStateProperty.resolveWith<EdgeInsets>(
            (Set<MaterialState> states) => EdgeInsets.all(padding),
          ),
          side: MaterialStateProperty.resolveWith<BorderSide>(
            (Set<MaterialState> states) => borderSide,
          ),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
            (Set<MaterialState> states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)),
          ),
          animationDuration: animationDuration),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leftIcon != null
              ? Icon(leftIcon)
              : const SizedBox(
                  width: 24,
                ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                text,
                style: textStyle,
              )),
          rightIcon != null
              ? Icon(rightIcon)
              : const SizedBox(
                  width: 24,
                )
        ],
      ),
    );
  }
}
