import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/model/billing_container_data.dart';
import 'package:hueveria_nieto_clientes/model/billing_data.dart';
import 'package:hueveria_nieto_clientes/model/client_model.dart';
import 'package:hueveria_nieto_clientes/model/order_billing_data.dart';
import 'package:hueveria_nieto_clientes/ui/components/component_billing.dart';
import 'package:hueveria_nieto_clientes/firebase/firebase_utils.dart';
import 'package:hueveria_nieto_clientes/ui/views/billing_detail_page.dart';
import 'package:hueveria_nieto_clientes/values/utils.dart';

import '../../custom/app_theme.dart';
import '../../custom/custom_colors.dart';
import '../../model/order_model.dart';
import '../components/component_panel.dart';

class BillingPage extends StatefulWidget {
  final ClientModel clientModel;

  const BillingPage(this.clientModel, {Key? key}) : super(key: key);

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
              color: CustomColors.whiteColor,
            ),
            toolbarHeight: 56.0,
            title: const Text(
              'Facturación',
              style: TextStyle(fontSize: 18.0),
            )),
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.all(16),
                child: const Text(
                    "En esta sección, podrá consultar la facturación de cada mes. A continuación, se muestran los meses disponibles.\nRecuerde que la facturación del mes vigente no es definitiva.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic
                    ),)),
            Container(
              width: double.infinity,
              height: 1,
              color: CustomColors.redPrimaryColor,
            ),
            StreamBuilder(
                stream:
                    FirebaseUtils.instance.getOrders(clientModel.doocumentId),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      final data = snapshot.data;
                      final List orderList = data.docs;
                      List<OrderBillingData> orderBillingDataList =
                          getOrderBillingData(orderList);
                      List<BillingContainerData> billingContainerDataList =
                          getBillingContainerFromOrderData(
                              orderBillingDataList);
                      if (billingContainerDataList.isNotEmpty) {
                        return Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: billingContainerDataList.length,
                                itemBuilder: (context, i) {
                                  final BillingContainerData
                                      billingContainerData =
                                      billingContainerDataList[i];
                                  bool isCurrentMonth;
                                  if (billingContainerData.initDate
                                          .toDate()
                                          .month ==
                                      DateTime.now().month) {
                                    isCurrentMonth = true;
                                  } else {
                                    isCurrentMonth = false;
                                  }

                                  double top = 8;
                                  double bottom = 0;
                                  if (i == 0) {
                                    top = 24;
                                  }
                                  if (i == billingContainerDataList.length) {
                                    bottom = 16;
                                  }
                                  return Container(
                                    margin: EdgeInsets.fromLTRB(
                                        24, top, 24, bottom),
                                    child: HNComponentBilling(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => BillingDetailPage(
                                                  billingContainerData
                                                      .billingData!,
                                                  isCurrentMonth)));
                                    }, billingContainerData),
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
        final OrderModel order =
            OrderModel.fromMap(item.data() as Map<String, dynamic>, item.id);
        orderBillingModelList.add(OrderBillingData(
            order.orderId,
            order.orderDatetime,
            order.paymentMethod,
            order.totalPrice,
            order.paid));
      }
    }
    return orderBillingModelList;
  }

  List<BillingContainerData> getBillingContainerFromOrderData(
      List<OrderBillingData> orderBillingDataList) {
    List<BillingContainerData> billingContainerDataList = [];
    List<OrderBillingData> orderBillingDataListAux = orderBillingDataList;

    double paymentByCash = 0;
    double paymentByReceipt = 0;
    double paymentByTransfer = 0;
    double paid = 0;
    double toBePaid = 0;
    double totalPrice = 0;

    orderBillingDataListAux
        .sort((a, b) => b.orderDatetime.compareTo(a.orderDatetime));

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

    Timestamp initDateTimestamp = Utils().parseStringToTimestamp("$y-$m-01");
    Timestamp endDateTimestamp = Timestamp.fromDate(DateTime(
        initDateTimestamp.toDate().year,
        initDateTimestamp.toDate().month + 1,
        initDateTimestamp.toDate().day));

    for (var item in orderBillingDataListAux) {
      if (item.orderDatetime.compareTo(initDateTimestamp) < 0) {
        BillingData billingData = BillingData(paymentByCash, paymentByReceipt,
            paymentByTransfer, paid, toBePaid, totalPrice);
        BillingContainerData billingContainerData = BillingContainerData(
            initDateTimestamp, endDateTimestamp, billingData);
        billingContainerDataList.add(billingContainerData);
        endDateTimestamp = initDateTimestamp;
        initDateTimestamp = Timestamp.fromDate(DateTime(
            initDateTimestamp.toDate().year,
            initDateTimestamp.toDate().month - 1,
            initDateTimestamp.toDate().day));
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
        BillingData billingData = BillingData(paymentByCash, paymentByReceipt,
            paymentByTransfer, paid, toBePaid, totalPrice);
        BillingContainerData billingContainerData = BillingContainerData(
            initDateTimestamp, endDateTimestamp, billingData);
        billingContainerDataList.add(billingContainerData);
      }
    }
    return billingContainerDataList;
  }
}
