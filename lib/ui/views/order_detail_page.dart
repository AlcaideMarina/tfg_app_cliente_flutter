import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/custom/custom_colors.dart';
import 'package:intl/intl.dart';

import '../../custom/app_theme.dart';
import '../../model/client_model.dart';
import '../../model/order_model.dart';
import '../../values/utils.dart';
import '../components/component_cell_table_form.dart';
import '../components/component_simple_form.dart';
import '../components/component_table_form.dart';
import '../components/component_table_form_with_subtitles.dart';
import '../components/component_text_input.dart';
import 'package:hueveria_nieto_clientes/values/constants.dart' as constants;

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage(this.clientModel, this.orderModel, {Key? key})
      : super(key: key);

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
              color: CustomColors.whiteColor
            ),
            toolbarHeight: 56.0,
            title: const Text(
              'Detalle de pedido',
              style: TextStyle(fontSize: 18.0),
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
                      Row(
                        children: [
                          const Text("ID pedido:", style: TextStyle(fontWeight: FontWeight.bold),),
                          const SizedBox(width: 8,),
                          Text(orderModel.orderId.toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      getAllFormElements(),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        "No se puede modificar ni anular el pedido. Para cualquier duda o problema, ppóngase en contacto con nosotros.",
                        textAlign: TextAlign.center,
                      ),
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
      deliveryDatetimeAux =
          "$status - ${dateFormat.format(orderModel.approxDeliveryDatetime.toDate())}";
    } else if (orderModel.status == 4) {
      deliveryDatetimeAux =
          dateFormat.format(orderModel.deliveryDatetime!.toDate());
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
        getCompanyComponentSimpleForm(
            'Empresa', null, TextInputType.text, clientModel.company),
        getCompanyComponentSimpleForm(
            'Dirección', null, TextInputType.text, clientModel.direction),
        getCompanyComponentSimpleForm(
            'CIF', null, TextInputType.text, clientModel.cif,
            textCapitalization: TextCapitalization.characters),
        getComponentTableForm('Teléfono', getTelephoneTableRow()),
        getComponentTableWithSubtitlesForm('Pedido', getPricePerUnitTableRow()),
        getComponentTableForm(
            'Precio total', getTotalPriceComponentSimpleForm(),
            columnWidhts: {1: const IntrinsicColumnWidth()}),
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 150,
                child: CheckboxListTile(
                  title: Text("Pagado"),
                  enabled: false,
                  value: orderModel.paid,
                  onChanged: (newValue) {},
                  dense: true,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            ],
          ),
        ),
        getCompanyComponentSimpleForm('Fecha pedido', null, TextInputType.text,
            dateFormat.format(orderModel.orderDatetime.toDate())),
        getCompanyComponentSimpleForm(
            'Fecha de entrega', null, TextInputType.text, deliveryDatetimeAux),
        getCompanyComponentSimpleForm('Repartidor', null, TextInputType.text,
            (orderModel.deliveryPerson ?? "-").toString()),
        getCompanyComponentSimpleForm('Albarán', null, TextInputType.text,
            (orderModel.deliveryNote ?? "-").toString()),
        getCompanyComponentSimpleForm('DNI de entrega', null,
            TextInputType.text, (orderModel.deliveryDni ?? "-").toString()),
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textInputType: textInputType,
        isEnabled: false,
        initialValue: value,
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget getComponentTableForm(String label, List<TableRow> children,
      {Map<int, TableColumnWidth>? columnWidhts}) {
    double topMargin = 4;
    double bottomMargin = 4;

    return HNComponentTableForm(
      "$label:",
      8,
      TableCellVerticalAlignment.middle,
      children,
      EdgeInsets.only(top: topMargin, bottom: bottomMargin),
      columnWidths: columnWidhts,
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget getComponentTableWithSubtitlesForm(String label, List<Widget> children,) {
    double topMargin = 4;
    double bottomMargin = 4;

    return HNComponentTableFormWithSubtitles(
      label + ":",
      8,
      TableCellVerticalAlignment.middle,
      children,
      EdgeInsets.only(top: topMargin, bottom: bottomMargin),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  List<TableRow> getTelephoneTableRow() {
    return [
      TableRow(children: [
        HNComponentCellTableForm(
            40, const EdgeInsets.only(left: 16, right: 8, bottom: 8),
            componentTextInput: HNComponentTextInput(
              textInputType: TextInputType.number,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              initialValue: clientModel.phone[0].values.first.toString(),
              isEnabled: false,
            )),
        HNComponentCellTableForm(
            40, const EdgeInsets.only(left: 8, right: 16, bottom: 8),
            componentTextInput: HNComponentTextInput(
              textCapitalization: TextCapitalization.words,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              initialValue: clientModel.phone[0].keys.first,
              isEnabled: false,
            )),
      ]),
      TableRow(children: [
        HNComponentCellTableForm(40, const EdgeInsets.only(left: 16, right: 8),
            componentTextInput: HNComponentTextInput(
              textInputType: TextInputType.number,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              initialValue: clientModel.phone[1].keys.first,
              isEnabled: false,
            )),
        HNComponentCellTableForm(40, const EdgeInsets.only(left: 8, right: 16),
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

  List<Widget> getPricePerUnitTableRow() {
    List<Widget> list = [];

    for (var item in constants.productClasses) {
      String dozenKey = "${item.toLowerCase()}_dozen";
      String boxKey = "${item.toLowerCase()}_box";
      num? dozenPrice;
      num dozenQuantity = 0;
      num? boxPrice;
      num boxQuantity = 0;

      if (orderModel.order.containsKey(dozenKey) &&
          orderModel.order[dozenKey] != null) {
        if (orderModel.order[dozenKey]!.containsKey("price")) {
          dozenPrice = orderModel.order[dozenKey]!["price"];
        }
        if (orderModel.order[dozenKey]!.containsKey("quantity") &&
            orderModel.order[dozenKey]!["quantity"] != null) {
          dozenQuantity = orderModel.order[dozenKey]!["quantity"]!;
        }
      }
      if (orderModel.order.containsKey(boxKey) &&
          orderModel.order[boxKey] != null) {
        if (orderModel.order[boxKey]!.containsKey("price")) {
          boxPrice = orderModel.order[boxKey]!["price"];
        }
        if (orderModel.order[boxKey]!.containsKey("quantity") &&
            orderModel.order[boxKey]!["quantity"] != null) {
          boxQuantity = orderModel.order[boxKey]!["quantity"]!;
        }
      }

      list.add(
        Container(
          child: Text("Huevos tamaño " + item + ":", style: const TextStyle(fontWeight: FontWeight.bold)),
          margin: const EdgeInsets.only(left: 12, right: 16),
        ));
      list.add(
        const SizedBox(height: 4,)
      );

      list.add(
        Table(
          columnWidths: const {
              0: IntrinsicColumnWidth(),
              2: FixedColumnWidth(96)
            },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 24, right: 16),
                    child: const Text("Docena")),
                Container(
                  height: 40,
                  margin: const EdgeInsets.only(left: 0, right: 4, bottom: 0),
                  child: HNComponentTextInput(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    textInputType: const TextInputType.numberWithOptions(),
                    labelText: dozenQuantity.toString(),
                    isEnabled: false,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only( right: 16),
                    child: Text("${dozenPrice ?? "-"} €/ud", textAlign: TextAlign.end,)),
              ],
            ),
            TableRow(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 24, right: 16),
                    child: const Text("Caja")),
                Container(
                  height: 40,
                  margin: const EdgeInsets.only(left: 0, right: 4, bottom: 0),
                  child: HNComponentTextInput(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    textInputType: const TextInputType.numberWithOptions(),
                    labelText: boxQuantity.toString(),
                    isEnabled: false,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: Text("${boxPrice ?? "-"} €/ud", textAlign: TextAlign.end,)),
              ]
            )
          ]
        ));
        
      list.add(
        const SizedBox(height: 4,)
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

    list.add(TableRow(children: [
      Container(
        height: 40,
        margin: const EdgeInsets.only(left: 8, right: 16, bottom: 0),
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
              margin: const EdgeInsets.only(left: 12, right: 16),
              child: Text("€"),
            )
    ]));

    return list;
  }
}
