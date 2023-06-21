import 'package:flutter/material.dart';

/// Forms table component.
/// Its TableRow's are made up of ComponentCellTableForm.

class HNComponentTableFormWithSubtitles extends StatelessWidget {
  final String label;
  final double spaceBetween;
  final TableCellVerticalAlignment defaultVerticalAlignment;
  final List<Widget> tableChildren;
  final EdgeInsets containerMargin;
  final TextStyle? textStyle;

  const HNComponentTableFormWithSubtitles(this.label, this.spaceBetween,
      this.defaultVerticalAlignment, this.tableChildren, this.containerMargin,
      {Key? key, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: containerMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: textStyle,),
          SizedBox(
            height: spaceBetween,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tableChildren,
          )
        ],
      ),
    );
  }
}
