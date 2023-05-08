import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/model/client_model.dart';
import 'package:hueveria_nieto_clientes/model/db_order_field_data.dart';
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


class MyOrdersPage extends StatefulWidget {

  final ClientModel clientModel;
  final bool fromNewOrderPage;

  const MyOrdersPage(
    this.clientModel, 
    this.fromNewOrderPage,
    {Key? key}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  late ClientModel clientModel;
  late bool fromNewOrderPage;
  bool showProgress = false;

  @override
  void initState() {
    super.initState();
    clientModel = widget.clientModel;
    fromNewOrderPage = widget.fromNewOrderPage;
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
              'Mis pedidos',
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
                      if (orderList.isNotEmpty) {
                        return Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: orderList.length,
                                itemBuilder: (context, i) {
                                  final OrderModel order =
                                      OrderModel.fromMap(orderList[i].data()
                                          as Map<String, dynamic>);
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 8),
                                    child: HNComponentOrders(
                                        order.orderDatetime,
                                        order.orderId.toString(),
                                        Utils().getOrderSummary(DBOrderFieldData.fromMap(order.order)),
                                        order.totalPrice,
                                        order.status,
                                        order.deliveryDni,
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailPage(clientModel, order)));
                                        },),
                                  );
                                }));
                      } else {
                        return Container(
                            margin: const EdgeInsets.fromLTRB(32, 56, 32, 8),
                            child: const HNComponentPanel(
                              title: 'No hay clientes',
                              text:
                                  "No hay registro de clientes activos en la base de datos.",
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
                                "No hay registro de clientes activos en la base de datos.",
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
}