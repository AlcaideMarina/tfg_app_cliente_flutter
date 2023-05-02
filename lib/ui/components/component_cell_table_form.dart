import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/ui/components/component_dropdown.dart';

import 'component_text_input.dart';

/// Forms HNComponentTextInput component (to use it in HNComponentSimpleForm or HNComponentTableForm)
/// This set the Container in which the HNComponentTextInput is wrapped. 

class HNComponentCellTableForm extends StatelessWidget {
  final double height;
  final EdgeInsets containerMargin;
  final HNComponentTextInput? componentTextInput;
  final HNComponentDropdown? componentDropdown;

  const HNComponentCellTableForm(
      this.height, 
      this.containerMargin,
      {Key? key,  
      this.componentTextInput,
      this.componentDropdown,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height, 
        margin: containerMargin, 
        child: componentTextInput ?? componentDropdown);
  }
}
