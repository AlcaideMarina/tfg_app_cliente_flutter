import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/model/billing_container_data.dart';
import 'package:hueveria_nieto_clientes/model/billing_data.dart';
import 'package:hueveria_nieto_clientes/model/client_model.dart';
import 'package:hueveria_nieto_clientes/model/db_order_field_data.dart';
import 'package:hueveria_nieto_clientes/model/order_billing_data.dart';
import 'package:hueveria_nieto_clientes/ui/components/component_billing.dart';
import 'package:hueveria_nieto_clientes/ui/components/component_order.dart';
import 'package:hueveria_nieto_clientes/firebase/firebase_utils.dart';
import 'package:hueveria_nieto_clientes/ui/views/order_detail_page.dart';
import 'package:hueveria_nieto_clientes/values/utils.dart';

import '../../custom/app_theme.dart';
import '../../custom/custom_colors.dart';
import '../../model/order_model.dart';
import '../components/component_panel.dart';
import '../components/constants/hn_button.dart';
import 'dart:developer' as developer;


class BillingPage extends StatefulWidget {

  final ClientModel clientModel;
  final bool fromNewOrderPage;

  const BillingPage(
    this.clientModel, 
    this.fromNewOrderPage,
    {Key? key}) : super(key: key);

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  late ClientModel clientModel;
  bool showProgress = false;

  @override
  void initState() {
    super.initState();
    clientModel = widget.clientModel;
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            toolbarHeight: 56.0,
            title: const Text(
              'Facturación',
              style: TextStyle(
                  color: AppTheme.primary, fontSize: 24.0),
            )),
        body: Column(
          children: [
            StreamBuilder(
                stream: FirebaseUtils.instance.getOrders(clientModel.doocumentId),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      final data = snapshot.data;
                      final List orderList = data.docs;
                      List<OrderBillingData> orderBillingDataList = getOrderBillingData(orderList);
                      List<BillingContainerData> billingContainerDataList = getBillingContainerFromOrderData(orderBillingDataList);
                      if (billingContainerDataList.isNotEmpty) {
                        return Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: billingContainerDataList.length,
                                itemBuilder: (context, i) {
                                  final BillingContainerData billingContainerData = billingContainerDataList[i];
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 8),
                                    child: HNComponentBilling(
                                        () {},
                                        billingContainerData
                                    ),
                                  );
                                }));
                      } else {
                        return Container(
                            margin: const EdgeInsets.fromLTRB(32, 56, 32, 8),
                            child: const HNComponentPanel(
                              title: 'No hay facturas',
                              text:
                                  "No hay registro de facturas disponibles en la base de datos.",
                            ));
                      }
                    } else if (snapshot.hasError) {
                      return Container(
                          margin: const EdgeInsets.fromLTRB(32, 56, 32, 8),
                          child: const HNComponentPanel(
                            title: 'Ha ocurrido un error',
                            text:
                                "Lo sentimos, pero ha habido un error al intentar recuperar los datos. Por favor, inténtelo de nuevo más tarde.",
                          ));
                    } else {
                      return Container(
                          margin: const EdgeInsets.fromLTRB(32, 56, 32, 8),
                          child: const HNComponentPanel(
                            title: 'No hay clientes',
                            text:
                                "No hay registro de facturas disponibles en la base de datos.",
                          ));
                    }
                  }
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: CustomColors.redPrimaryColor,
                      ),
                    ),
                  );
                }),
          ],
        ));
  }

  List<OrderBillingData> getOrderBillingData(List list) {
    List<OrderBillingData> orderBillingModelList = [];

    for (var item in list) {
      if (item != null && item.data() != null) {
        final OrderModel order = OrderModel.fromMap(item.data() as Map<String, dynamic>);
        orderBillingModelList.add(
          OrderBillingData(
            order.orderId, 
            order.orderDatetime, 
            order.paymentMethod, 
            order.totalPrice, 
            order.paid
          )
        );
      }
    }
    return orderBillingModelList;
  }

  List<BillingContainerData> getBillingContainerFromOrderData(List<OrderBillingData> orderBillingDataList) {
    List<BillingContainerData> billingContainerDataList = [];
    List<OrderBillingData> orderBillingDataListAux = orderBillingDataList;

    double paymentByCash = 0;
    double paymentByReceipt = 0;
    double paymentByTransfer = 0;
    double paid = 0;
    double toBePaid = 0;
    double totalPrice = 0;
    
    // TODO: Revisar esto: no estoy nada segura de que lo esté haciendo bien
    orderBillingDataListAux.sort((a, b) => b.orderDatetime.compareTo(a.orderDatetime));

    OrderBillingData firstOrder = orderBillingDataListAux[0];
    DateTime firstDate = firstOrder.orderDatetime.toDate();

    var m = firstDate.month.toString();
    while (m.length < 2) {
      m = "0$m";
    }
    var y = firstDate.year.toString();
    while (y.length < 4) {
      y = "0$y";
    }

    Timestamp initDateTimestamp = Utils().parseStringToTimestamp("01/$m/$y");
    Timestamp endDateTimestamp = Timestamp.fromDate(initDateTimestamp.toDate().add(const Duration(days: 3)));

    for (var item in orderBillingDataListAux) {
      if (Timestamp.now().compareTo(initDateTimestamp) >= 0 && 
          Timestamp.now().compareTo(endDateTimestamp) < 0) {
            BillingData billingData = BillingData(
              paymentByCash,
              paymentByReceipt,
              paymentByTransfer,
              paid,
              toBePaid,
              totalPrice
            );
            BillingContainerData billingContainerData = BillingContainerData(
              initDateTimestamp,
              endDateTimestamp,
              billingData
            );
            billingContainerDataList.add(billingContainerData);
            paymentByCash = 0;
            paymentByReceipt = 0;
            paymentByTransfer = 0;
            paid = 0;
            toBePaid = 0;
            totalPrice = 0;
      }

      if (item.paymentMethod == 0) {
        paymentByCash += (item.totalPrice ?? 0).toDouble();
      } else if (item.paymentMethod == 1) {
        paymentByReceipt += (item.totalPrice ?? 0).toDouble();
      } else if (item.paymentMethod == 2) {
        paymentByTransfer += (item.totalPrice ?? 0).toDouble();
      }

      if (item.paid) {
        paid += (item.totalPrice ?? 0).toDouble();
      } else {
        toBePaid += (item.totalPrice ?? 0).toDouble();
      }

      totalPrice += (item.totalPrice ?? 0).toDouble();

      if (orderBillingDataListAux.last == item) {
        BillingData billingData = BillingData(
          paymentByCash, 
          paymentByReceipt, 
          paymentByTransfer, 
          paid, 
          toBePaid, 
          totalPrice
        );
        BillingContainerData billingContainerData = BillingContainerData(
          initDateTimestamp,
          endDateTimestamp,
          billingData
        );
        billingContainerDataList.add(billingContainerData);
      }

    }
    return billingContainerDataList;
  }

}
