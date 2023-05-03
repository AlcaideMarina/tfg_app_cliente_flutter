import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../custom/custom_colors.dart';
import '../../values/utils.dart';

class HNComponentOrders extends StatelessWidget {
  
  final Timestamp orderDatetime;
  final String id;
  final String orderSummary;
  final double? price;
  final int status;
  final String? deliveryDni;
  final Function()? onTap;

  HNComponentOrders(
    this.orderDatetime, 
    this.id,
    this.orderSummary, 
    this.price,
    this.status,
    this.deliveryDni,
    {Key? key, this.onTap,}) : super(key: key);

    
  final DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {

    String orderDatetimeStr = dateFormat.format(orderDatetime.toDate());

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
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(orderDatetimeStr, style: TextStyle(fontSize: 10),),
              Text("Pedido: $id"),
              Text(orderSummary),
              Text("Precio: $price €"),
              Text(Utils().orderStatusIntToString(status) ?? "Estado desconocido"),
              deliveryDni != null ? Text("DNI de recogida: $deliveryDni") : const SizedBox(),
            ],
          ),
          // TODO: Cambiar icono - creo que se va a tener que importar
          const Icon(Icons.arrow_right_alt_outlined)
        ],
      ),
    ));
  }
}
