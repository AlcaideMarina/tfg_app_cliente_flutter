import 'package:flutter/material.dart';

import 'component_cell_table_form.dart';
import 'component_dropdown.dart';
import 'component_text_input.dart';

/// Forms component.
/// It is made up of a label and a textInput.

class HNComponentSimpleForm extends StatelessWidget {
  final String label;
  final double spaceBetween;
  final double textInputHeight;
  final EdgeInsets textInputMargin;
  final HNComponentTextInput? componentTextInput;
  final HNComponentDropdown? componentDropdown;
  final EdgeInsets containerMargin;
  final EdgeInsets? textMargin;

  const HNComponentSimpleForm(
      this.label,
      this.spaceBetween,
      this.textInputHeight,
      this.textInputMargin,
      this.containerMargin,
      {Key? key,
      this.componentTextInput,
      this.componentDropdown,
      this.textMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: containerMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(margin: textMargin, child: Text(label)),
          SizedBox(
            height: spaceBetween,
          ),
          HNComponentCellTableForm(
              textInputHeight, 
              textInputMargin, 
              componentTextInput: componentTextInput,
              componentDropdown: componentDropdown,),
        ],
      ),
    );
  }
}
