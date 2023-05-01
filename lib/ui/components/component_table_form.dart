import 'package:flutter/material.dart';

/// Forms table component.
/// Its TableRow's are made up of ComponentCellTableForm.

class HNComponentTableForm extends StatelessWidget {
  final String label;
  final double spaceBetween;
  final TableCellVerticalAlignment defaultVerticalAlignment;
  final List<TableRow> tableChildren;
  final EdgeInsets containerMargin;
  final Map<int, TableColumnWidth>? columnWidths;

  const HNComponentTableForm(this.label, this.spaceBetween,
      this.defaultVerticalAlignment, this.tableChildren, this.containerMargin,
      {Key? key, this.columnWidths})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: containerMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          SizedBox(
            height: spaceBetween,
          ),
          Table(
            columnWidths: columnWidths,
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: tableChildren,
          )
        ],
      ),
    );
  }
}
