import 'package:flutter/material.dart';

import '../../../custom/custom_colors.dart';
import '../component_ button.dart';

/// In this class, you will find all the types of buttons available in design.

enum ButtonTypes {
  redWhiteRoundedButton,
  redWhiteBoldRoundedButton,
  grayBlackRoundedButton,
  grayBlackBoldRoundedButton,
  whiteRedRoundedButton,
  whiteRedBoldRoundedButton,
  whiteBlackRoundedButton,
  whiteBlackBoldRoundedButton,
  blackGrayRoundedButton,
  blackGrayBoldRoundedButton,
  blackWhiteRoundedButton,
  blackWhiteBoldRoundedButton,
  blackRedRoundedButton,
  blackRedBoldRoundedButton,

  redWhiteCricleButton,
  redWhiteBoldCricleButton,
  grayBlackCricleButton,
  grayBlackBoldCricleButton,
  whiteRedCricleButton,
  whiteRedBoldCricleButton,
  whiteBlackCricleButton,
  whiteBlackBoldCricleButton,
  blackGrayCricleButton,
  blackGrayBoldCricleButton,
  blackWhiteCricleButton,
  blackWhiteBoldCricleButton,
  blackRedCricleButton,
  blackRedBoldCricleButton,
}

/// This is the class which implements the button features.
/// It is setted by the button type, but can be modify

class HNButton {
  final ButtonTypes type;

  HNButton(this.type);

  late double radius;
  double circleRadius = 100.0;
  double roundedRadius = 16.0;
  TextStyle textStyle = const TextStyle(fontWeight: FontWeight.bold);
  FontWeight? fontWeight;
  Color? fontColor;
  bool autofocus = false;
  Clip clipBehavior = Clip.none;
  late Color backgroundColor;
  late Color onPrimaryColor;
  double elevation = 0.0;
  double padding = 15.0;
  BorderSide borderSide = const BorderSide(style: BorderStyle.none);
  Duration? animationDuration;

  ComponentButton getTypedButton(
    String text,
    IconData? leftIcon,
    IconData? rightIcon,
    VoidCallback? onPressed,
    VoidCallback? onLongPressed, {
    double? customRadius,
    TextStyle? customTextStyle,
    bool? customAutofocus,
    Clip? customClipBehavior,
    Color? customBackgroundColor,
    Color? customOnPrimaryColor,
    double? customElevation,
    double? customPadding,
    BorderSide? customBorderSide,
    Duration? customAnimationDuration,
  }) {
    autofocus = customAutofocus ?? autofocus;
    clipBehavior = customClipBehavior ?? clipBehavior;
    elevation = customElevation ?? elevation;
    padding = customPadding ?? padding;
    borderSide = customBorderSide ?? borderSide;
    animationDuration = customAnimationDuration ?? const Duration(seconds: 0);

    switch (type) {
      case ButtonTypes.redWhiteRoundedButton:
        radius = customRadius ?? roundedRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.redPrimaryColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.whiteColor;
        textStyle = customTextStyle ?? const TextStyle(color: CustomColors.whiteColor);
        break;

      case ButtonTypes.redWhiteBoldRoundedButton:
        radius = customRadius ?? roundedRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.redPrimaryColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.whiteColor;
        textStyle = customTextStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: CustomColors.whiteColor);
        break;

      case ButtonTypes.grayBlackRoundedButton:
        radius = customRadius ?? roundedRadius;
        backgroundColor =
            customBackgroundColor ?? CustomColors.redGraySecondaryColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.blackColor;
        textStyle = customTextStyle ?? const TextStyle(color: CustomColors.blackColor);
        break;

      case ButtonTypes.grayBlackBoldRoundedButton:
        radius = customRadius ?? roundedRadius;
        backgroundColor =
            customBackgroundColor ?? CustomColors.redGraySecondaryColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.blackColor;
        textStyle = customTextStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: CustomColors.blackColor);
        break;

      case ButtonTypes.whiteRedRoundedButton:
        radius = customRadius ?? roundedRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.whiteColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.redPrimaryColor;
        textStyle = customTextStyle ?? const TextStyle(color: CustomColors.redPrimaryColor);
        break;

      case ButtonTypes.whiteRedBoldRoundedButton:
        radius = customRadius ?? roundedRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.whiteColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.redPrimaryColor;
        textStyle = customTextStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: CustomColors.redPrimaryColor);
        break;

      case ButtonTypes.whiteBlackRoundedButton:
        radius = customRadius ?? roundedRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.whiteColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.blackColor;
        textStyle = customTextStyle ?? const TextStyle(color: CustomColors.blackColor);
        break;

      case ButtonTypes.whiteBlackBoldRoundedButton:
        radius = customRadius ?? roundedRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.whiteColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.blackColor;
        textStyle = customTextStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: CustomColors.blackColor);
        break;

      case ButtonTypes.redWhiteCricleButton:
        radius = customRadius ?? circleRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.redPrimaryColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.whiteColor;
        textStyle = customTextStyle ?? const TextStyle(color: CustomColors.whiteColor);
        break;

      case ButtonTypes.redWhiteBoldCricleButton:
        radius = customRadius ?? circleRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.redPrimaryColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.whiteColor;
        textStyle = customTextStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: CustomColors.whiteColor);
        break;

      case ButtonTypes.grayBlackCricleButton:
        radius = customRadius ?? circleRadius;
        backgroundColor =
            customBackgroundColor ?? CustomColors.redGraySecondaryColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.blackColor;
        textStyle = customTextStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: CustomColors.blackColor);
        break;

      case ButtonTypes.grayBlackBoldCricleButton:
        radius = customRadius ?? circleRadius;
        backgroundColor =
            customBackgroundColor ?? CustomColors.redGraySecondaryColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.blackColor;
        textStyle = customTextStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: CustomColors.blackColor);
        break;

      case ButtonTypes.whiteRedCricleButton:
        radius = customRadius ?? circleRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.whiteColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.redPrimaryColor;
        textStyle = customTextStyle ?? const TextStyle(color: CustomColors.blackColor);
        break;

      case ButtonTypes.whiteRedBoldCricleButton:
        radius = customRadius ?? circleRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.whiteColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.redPrimaryColor;
        textStyle = customTextStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: CustomColors.redPrimaryColor);
        break;

      case ButtonTypes.whiteBlackCricleButton:
        radius = customRadius ?? circleRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.whiteColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.blackColor;
        textStyle = customTextStyle ?? const TextStyle(color: CustomColors.blackColor);
        break;

      case ButtonTypes.whiteBlackBoldCricleButton:
        radius = customRadius ?? circleRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.whiteColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.blackColor;
        textStyle = customTextStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: CustomColors.blackColor);
        break;

      case ButtonTypes.blackGrayRoundedButton:
        radius = customRadius ?? roundedRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.blackColor;
        onPrimaryColor =
            customOnPrimaryColor ?? CustomColors.redGraySecondaryColor;
        textStyle = customTextStyle ?? const TextStyle(color: CustomColors.redGraySecondaryColor);
        break;
      case ButtonTypes.blackGrayBoldRoundedButton:
        radius = customRadius ?? roundedRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.blackColor;
        onPrimaryColor =
            customOnPrimaryColor ?? CustomColors.redGraySecondaryColor;
        textStyle = customTextStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: CustomColors.redGraySecondaryColor);
        break;
      case ButtonTypes.blackWhiteRoundedButton:
        radius = customRadius ?? roundedRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.blackColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.whiteColor;
        textStyle = customTextStyle ?? const TextStyle(color: CustomColors.whiteColor);
        break;
      case ButtonTypes.blackWhiteBoldRoundedButton:
        radius = customRadius ?? roundedRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.blackColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.whiteColor;
        textStyle = customTextStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: CustomColors.whiteColor);
        break;
      case ButtonTypes.blackRedRoundedButton:
        radius = customRadius ?? roundedRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.blackColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.redPrimaryColor;
        textStyle = customTextStyle ?? const TextStyle(color: CustomColors.redPrimaryColor);
        break;
      case ButtonTypes.blackRedBoldRoundedButton:
        radius = customRadius ?? roundedRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.blackColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.redPrimaryColor;
        textStyle = customTextStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: CustomColors.redPrimaryColor);
        break;
      case ButtonTypes.blackGrayCricleButton:
        radius = customRadius ?? circleRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.blackColor;
        onPrimaryColor =
            customOnPrimaryColor ?? CustomColors.redGraySecondaryColor;
        textStyle = customTextStyle ?? const TextStyle(color: CustomColors.redGraySecondaryColor);
        break;
      case ButtonTypes.blackGrayBoldCricleButton:
        radius = customRadius ?? circleRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.blackColor;
        onPrimaryColor =
            customOnPrimaryColor ?? CustomColors.redGraySecondaryColor;
        textStyle = customTextStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: CustomColors.redGraySecondaryColor);
        break;
      case ButtonTypes.blackWhiteCricleButton:
        radius = customRadius ?? circleRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.blackColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.whiteColor;
        textStyle = customTextStyle ?? const TextStyle(color: CustomColors.whiteColor);
        break;
      case ButtonTypes.blackWhiteBoldCricleButton:
        radius = customRadius ?? circleRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.blackColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.whiteColor;
        textStyle = customTextStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: CustomColors.whiteColor);
        break;
      case ButtonTypes.blackRedCricleButton:
        radius = customRadius ?? circleRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.blackColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.redPrimaryColor;
        textStyle = customTextStyle ?? const TextStyle(color: CustomColors.redPrimaryColor);
        break;
      case ButtonTypes.blackRedBoldCricleButton:
        radius = customRadius ?? circleRadius;
        backgroundColor = customBackgroundColor ?? CustomColors.blackColor;
        onPrimaryColor = customOnPrimaryColor ?? CustomColors.redPrimaryColor;
        textStyle = customTextStyle ?? const TextStyle(fontWeight: FontWeight.bold, color: CustomColors.redPrimaryColor);
        break;
    }

    return ComponentButton(text,
        leftIcon: leftIcon,
        rightIcon: rightIcon,
        radius: radius,
        textStyle: textStyle,
        onPressed: onPressed,
        onLongPressed: onLongPressed,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        backgroundColor: backgroundColor,
        onPrimaryColor: onPrimaryColor,
        elevation: elevation,
        padding: padding,
        borderSide: borderSide,
    );
  }
}
