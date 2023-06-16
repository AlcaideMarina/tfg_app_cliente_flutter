
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../custom/app_theme.dart';
import '../../model/client_model.dart';
import '../../model/order_model.dart';
import '../../values/utils.dart';
import '../components/component_cell_table_form.dart';
import '../components/component_simple_form.dart';
import '../components/component_table_form.dart';
import '../components/component_text_input.dart';
import 'package:hueveria_nieto_clientes/values/constants.dart' as constants;


class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage(this.clientModel, this.orderModel, {Key? key}) : super(key: key);

  final ClientModel clientModel;
  final OrderModel orderModel;
  
  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late ClientModel clientModel;
  late OrderModel orderModel;

  @override
  void initState() {
    super.initState();
    clientModel = widget.clientModel;
    orderModel = widget.orderModel;
  }

  List<String> productClasses = ["XL", "L", "M", "S"];
  final DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            toolbarHeight: 56.0,
            title: const Text(
              'Ver pedido',
              style: TextStyle(
                  color: AppTheme.primary, fontSize: 24.0),
            )),
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ID pedido: ${orderModel.orderId.toString()}"),
                      getAllFormElements(),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        "No se puede modificar ni anular el pedido. Para cualquier duda o problema, ppóngase en contacto con nosotros.",
                        textAlign: TextAlign.center,),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }

  Widget getAllFormElements() {

    List<int> statusApproxDeliveryDatetimeList = [0, 1, 2];
    String deliveryDatetimeAux;
    if (statusApproxDeliveryDatetimeList.contains(orderModel.status)) {
      String status = Utils().getKey(constants.orderStatus, orderModel.status);
      deliveryDatetimeAux = "$status - ${dateFormat.format(orderModel.approxDeliveryDatetime.toDate())}";
    } else if (orderModel.status == 4) {
      deliveryDatetimeAux = dateFormat.format(orderModel.deliveryDatetime!.toDate());
    } else if (orderModel.status == 5) {
      String status = Utils().getKey(constants.orderStatus, orderModel.status);
      String dt;
      if (orderModel.deliveryDatetime != null) {
        dt = dateFormat.format(orderModel.deliveryDatetime!.toDate());
      } else {
        dt = "";
      }
      deliveryDatetimeAux = "$status - $dt";
    } else {
      String dt;
      if (orderModel.deliveryDatetime != null) {
        dt = dateFormat.format(orderModel.deliveryDatetime!.toDate());
      } else {
        dt = dateFormat.format(orderModel.approxDeliveryDatetime.toDate());
      }
      deliveryDatetimeAux = dt;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCompanyComponentSimpleForm('Empresa', null, TextInputType.text, clientModel.company),
        getCompanyComponentSimpleForm('Dirección', null, TextInputType.text, clientModel.direction),
        getCompanyComponentSimpleForm('CIF', null, TextInputType.text, clientModel.cif, textCapitalization: TextCapitalization.characters),
        getComponentTableForm('Teléfono', getTelephoneTableRow()),
        getComponentTableForm('Pedido', getPricePerUnitTableRow(), 
            columnWidhts: {
              0: const IntrinsicColumnWidth(),
              2: const IntrinsicColumnWidth()
            }),
        getComponentTableForm('Precio total', getTotalPriceComponentSimpleForm(),
            columnWidhts: {
              1: const IntrinsicColumnWidth()
            }),
        getCompanyComponentSimpleForm('Fecha pedido', null, TextInputType.text, dateFormat.format(orderModel.orderDatetime.toDate())),
        getCompanyComponentSimpleForm('Fecha de entrega', null, TextInputType.text, deliveryDatetimeAux),
        getCompanyComponentSimpleForm('Repartidor', null, TextInputType.text, (orderModel.deliveryPerson ?? "-").toString()),
        getCompanyComponentSimpleForm('Albarán', null, TextInputType.text, (orderModel.deliveryNote ?? "-").toString()),
        getCompanyComponentSimpleForm('DNI de entrega', null, TextInputType.text, (orderModel.deliveryDni ?? "-").toString()),
      ],
    );
  }

  Widget getCompanyComponentSimpleForm(String label, String? labelInputText,
      TextInputType textInputType, String value,
      {TextCapitalization textCapitalization = TextCapitalization.sentences}) {
    double topMargin = 4;
    double bottomMargin = 4;
    return HNComponentSimpleForm(
        '$label:',
        8,
        40,
        const EdgeInsets.symmetric(horizontal: 16),
        EdgeInsets.only(top: topMargin, bottom: bottomMargin),
        componentTextInput: HNComponentTextInput(
          textCapitalization: textCapitalization,
          labelText: labelInputText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textInputType: textInputType,
          isEnabled: false,
          initialValue: value,
        ),);
  }

  Widget getComponentTableForm(String label, List<TableRow> children,
      {Map<int, TableColumnWidth>? columnWidhts}) {
    double topMargin = 4;
    double bottomMargin = 4;

    return HNComponentTableForm(
      label,
      8,
      TableCellVerticalAlignment.middle,
      children,
      EdgeInsets.only(top: topMargin, bottom: bottomMargin),
      columnWidths: columnWidhts,
    );
  }

  List<TableRow> getTelephoneTableRow() {
    return [
      TableRow(children: [
        HNComponentCellTableForm(
            40,
            const EdgeInsets.only(left: 16, right: 8, bottom: 8),
            componentTextInput: HNComponentTextInput(
              textInputType: TextInputType.number,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              initialValue: clientModel.phone[0].values.first.toString(),
              isEnabled: false,
            )),
        HNComponentCellTableForm(
            40,
            const EdgeInsets.only(left: 8, right: 16, bottom: 8),
            componentTextInput: HNComponentTextInput(
              textCapitalization: TextCapitalization.words,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              initialValue: clientModel.phone[0].keys.first,
              isEnabled: false,
            )),
      ]),
      TableRow(children: [
        HNComponentCellTableForm(
            40,
            const EdgeInsets.only(left: 16, right: 8),
            componentTextInput: HNComponentTextInput(
              textInputType: TextInputType.number,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              initialValue: clientModel.phone[1].keys.first,
              isEnabled: false,
            )),
        HNComponentCellTableForm(
            40,
            const EdgeInsets.only(left: 8, right: 16),
            componentTextInput: HNComponentTextInput(
              textCapitalization: TextCapitalization.words,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              initialValue: clientModel.phone[1].values.first.toString(),
              isEnabled: false,
            )),
      ]),
    ];
  }

  List<TableRow> getPricePerUnitTableRow() {
    List<TableRow> list = [];

    for (var item in productClasses) {
      String dozenKey = "${item.toLowerCase()}_dozen";
      String boxKey = "${item.toLowerCase()}_box";
      num? dozenPrice;
      num dozenQuantity = 0;
      num? boxPrice;
      num boxQuantity = 0;

      if (orderModel.order.containsKey(dozenKey) && orderModel.order[dozenKey] != null) {
        if (orderModel.order[dozenKey]!.containsKey("price")) {
          dozenPrice = orderModel.order[dozenKey]!["price"];
        }
        if (orderModel.order[dozenKey]!.containsKey("quantity") && orderModel.order[dozenKey]!["quantity"] != null) {
          dozenQuantity = orderModel.order[dozenKey]!["quantity"]!;
        }
      }
      if (orderModel.order.containsKey(boxKey) && orderModel.order[boxKey] != null) {
        if (orderModel.order[boxKey]!.containsKey("price")) {
          boxPrice = orderModel.order[boxKey]!["price"];
        }
        if (orderModel.order[boxKey]!.containsKey("quantity") && orderModel.order[boxKey]!["quantity"] != null) {
          boxQuantity = orderModel.order[boxKey]!["quantity"]!;
        }
      }
      

      list.add(
        TableRow(
          children: [
            Container(
              child: Text(item),
              margin: const EdgeInsets.only(left: 12, right: 16),
            ),
            Container(),
            Container()
          ]
        )
      );

      list.add(
        TableRow(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 24, right: 16),
              child: Text("Docena")),
            Container(
              height: 40,
              margin: EdgeInsets.only(left: 8, right: 16, bottom: 0),
              child: HNComponentTextInput(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                textInputType: const TextInputType.numberWithOptions(),
                initialValue: dozenQuantity.toString(),
                isEnabled: false,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 24, right: 16),
              child: Text("${dozenPrice ?? "- "} €"))
          ],
        )
      );

      list.add(
        TableRow(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 24, right: 16),
              child: Text("Caja")),
            Container(
              height: 40,
              margin: EdgeInsets.only(left: 8, right: 16, bottom: 0),
              child: HNComponentTextInput(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                textInputType: const TextInputType.numberWithOptions(),
                initialValue: boxQuantity.toString(),
                isEnabled: false,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 24, right: 16),
              child: Text("${boxPrice ?? "- "} €"))
          ]
        )
      );
    }

    return list;
  }

  List<TableRow> getTotalPriceComponentSimpleForm() {
    double topMargin = 4;
    double bottomMargin = 4;
    
    List<TableRow> list = [];
    bool pricePending = true;
    String totalPriceAux = "Pendiente de precio";
    if (orderModel.totalPrice != null) {
      pricePending = false;
      totalPriceAux = orderModel.totalPrice.toString();
    }

    list.add(
      TableRow(
        children: [
          Container(
              height: 40,
              margin: EdgeInsets.only(left: 8, right: 16, bottom: 0),
              child: HNComponentTextInput(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                textInputType: const TextInputType.numberWithOptions(),
                initialValue: totalPriceAux,
                isEnabled: false,
              ),
            ),
          pricePending 
            ? Container() 
            : Container(
              child: Text("€"),
              margin: const EdgeInsets.only(left: 12, right: 16),
            )
        ]
      )
    );

    return list;
  }

}
