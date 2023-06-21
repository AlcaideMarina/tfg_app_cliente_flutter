import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/values/image_routes.dart';
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
    this.deliveryDni, {
    Key? key,
    this.onTap,
  }) : super(key: key);

  final DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

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
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderDatetimeStr,
                        style: const TextStyle(fontSize: 11),
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        children: [
                          const Text('ID Pedido: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                          Text(id.toString(), style: const TextStyle(fontSize: 15))
                        ],
                      ),
                      const SizedBox(height: 12,),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: CustomColors.redGrayLightSecondaryColor,
                        margin: const EdgeInsets.only(left: 12),
                      ),
                      const SizedBox(height: 12,),
                      const Text('Resumen del pedido: ', style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(orderSummary),
                      const SizedBox(height: 12,),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: CustomColors.redGrayLightSecondaryColor,
                        margin: const EdgeInsets.only(left: 12),
                      ),
                      const SizedBox(height: 12,),
                      Row(
                        children: [
                          const Text("Precio: ", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("${price ?? "-"} €", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        ],
                      ),
                      Text(Utils().orderStatusIntToString(status) ??
                          "Estado desconocido"),
                      deliveryDni != null ? Row(
                        children: [
                          const Text("DNI de recogida: ", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(deliveryDni!),
                        ],
                      ) : const SizedBox(),
                    ],
                  ),
                ),
              ),
              Image.asset(
                ImageRoutes.getRoute('ic_next_arrow'),
                width: 16,
                height: 24,
              )
            ],
          ),
        ));
  }
}
