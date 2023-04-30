import 'package:flutter/material.dart';

import '../../custom/custom_colors.dart';

/// Custom TextInput component

class HNComponentTextInput extends StatelessWidget {
  final bool autofocus;
  final String? initialValue;
  final TextCapitalization textCapitalization;
  final TextInputType? textInputType;
  final bool obscureText;
  final Function(String)? onChange;
  // validator
  final AutovalidateMode? autovalidateMode;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? suffixIcon;
  final IconData? icon;
  final bool? isDense;
  final bool? isEnabled;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? textEditingController;
  final Color? backgroundColor;
  final Color? textColor;

  const HNComponentTextInput(
      {Key? key,
      this.autofocus = false,
      this.initialValue,
      this.textCapitalization = TextCapitalization.sentences,
      this.obscureText = false,
      this.textInputType,
      this.onChange,
      // this.validator,
      this.autovalidateMode,
      this.hintText,
      this.labelText,
      this.helperText,
      this.suffixIcon,
      this.icon,
      this.isDense,
      this.isEnabled,
      this.contentPadding, 
      this.textEditingController,
      this.backgroundColor,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      initialValue: initialValue,
      textCapitalization: textCapitalization,
      keyboardType: textInputType,
      obscureText: obscureText,
      controller: textEditingController,
      onChanged: (value) => onChange != null ? onChange!(value) : null,
      validator: (value) {
        if (value == null) {
          return "Este campo es obligatorio";
        } else {
          return value.length < 3 ? 'Mínimo de 3 letras' : null;
        }
      },
      autovalidateMode: autovalidateMode,
      enabled: isEnabled,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        filled: backgroundColor != null,
        fillColor: backgroundColor,
        isDense: isDense,
        contentPadding: contentPadding,
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
        suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
        icon: icon == null ? null : Icon(icon),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: CustomColors.redPrimaryColor)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: CustomColors.redGraySecondaryColor)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: CustomColors.redPrimaryColor)),
      ),
    );
  }
}
