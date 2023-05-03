import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/model/billing_container_data.dart';
import 'package:intl/intl.dart';

import '../../custom/custom_colors.dart';

class HNComponentBilling extends StatelessWidget {

  final BillingContainerData data;
  final Function()? onTap;
  final DateFormat dateFormat = DateFormat("MMMM, yyyy");

  HNComponentBilling(this.onTap, this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    String orderDatetimeStr = dateFormat.format(data.initDate.toDate());

    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: CustomColors.redGraySecondaryColor,
            border: Border.all(
              color: CustomColors.redGraySecondaryColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Text(orderDatetimeStr, style: TextStyle(fontSize: 10),),
                ),
              ),
              // TODO: Cambiar icono - creo que se va a tener que importar
              const Icon(Icons.arrow_right_alt_outlined)
            ],
          ),
        ));
  }
}
