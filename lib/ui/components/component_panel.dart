import 'package:flutter/material.dart';

import '../../custom/custom_colors.dart';

class HNComponentPanel extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? text;
  final String? subtext;

  const HNComponentPanel(
      {Key? key, this.title, this.subtitle, this.text, this.subtext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double space1 = 0.0;
    double space2 = 0.0;
    double space3 = 0.0;

    if (title != null && subtitle != null) {
      space1 = 8.0;
    }
    if (text != null && subtext != null) {
      space3 = 8.0;
    }
    if ((title != null || subtitle != null) &&
        (text != null || subtext != null)) {
      space2 = 24.0;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
      decoration: BoxDecoration(
          color: CustomColors.redGraySecondaryColor,
          border: Border.all(
            color: CustomColors.redGraySecondaryColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          title == null
              ? Container()
              : Text(
                  title!,
                  style: const TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
          SizedBox(height: space1),
          subtitle == null
              ? Container()
              : Text(
                  subtitle!,
                  style: const TextStyle(
                      fontSize: 14.0, color: CustomColors.grayColor),
                  textAlign: TextAlign.center,
                ),
          SizedBox(height: space2),
          text == null
              ? Container()
              : Text(
                  text!,
                  style: const TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
          SizedBox(height: space3),
          subtext == null
              ? Container()
              : Text(
                  subtext!,
                  style: const TextStyle(
                      fontSize: 13.0, color: CustomColors.grayColor),
                  textAlign: TextAlign.center,
                )
        ],
      ),
    );
  }
}