import 'package:flutter/material.dart';

import '../../custom/custom_colors.dart';

class HNComponentDropdown extends StatelessWidget {
  final bool autofocus;
  final TextInputType? textInputType;
  final Function(Object?)? onChange;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? suffixIcon;
  final IconData? leftIcon;
  final IconData? dropdownIcon;
  final bool? isDense;
  final bool isExpanded;
  final bool? isEnabled;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColor;
  final List<String> items;

  const HNComponentDropdown(
    this.items,
    {Key? key,
      this.autofocus = false,
      this.textInputType,
      this.onChange,
      this.hintText,
      this.labelText,
      this.helperText,
      this.suffixIcon,
      this.leftIcon,
      this.dropdownIcon,
      this.isDense,
      this.isExpanded = true,
      this.isEnabled,
      this.contentPadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16), 
      this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
            autofocus: autofocus,
            icon: dropdownIcon == null ? null : const Icon(Icons.keyboard_arrow_down_rounded),
            isExpanded: isExpanded,
            decoration: InputDecoration(
              filled: backgroundColor != null,
              fillColor: backgroundColor,
              isDense: isDense,
              contentPadding: contentPadding,
              hintText: hintText,
              labelText: labelText,
              helperText: helperText,
              icon: leftIcon == null ? null : Icon(leftIcon),
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
            items: items.map((e){
              return DropdownMenuItem(
                value: e,
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    e,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) => onChange != null ? onChange!(value) : null,
            /*onChanged: (String? newValue) { 
              setState(() {
                dropdownvalue = newValue!;
              });
            },*/
          );
  }
}