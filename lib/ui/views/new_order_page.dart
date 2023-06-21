import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/custom/custom_colors.dart';
import 'package:hueveria_nieto_clientes/firebase/firebase_utils.dart';
import 'package:hueveria_nieto_clientes/model/client_model.dart';
import 'package:hueveria_nieto_clientes/model/db_order_field_data.dart';
import 'package:hueveria_nieto_clientes/model/order_model.dart';
import 'package:hueveria_nieto_clientes/ui/components/component_dropdown.dart';
import 'package:hueveria_nieto_clientes/ui/views/my_orders_page.dart';
import 'package:hueveria_nieto_clientes/values/utils.dart';
import 'package:intl/intl.dart';

import '../../custom/app_theme.dart';
import '../../model/egg_prices_data.dart';
import '../components/component_cell_table_form.dart';
import '../components/component_simple_form.dart';
import '../components/component_table_form.dart';
import '../components/component_table_form_with_subtitles.dart';
import '../components/component_text_input.dart';
import '../components/constants/hn_button.dart';
import 'package:hueveria_nieto_clientes/values/constants.dart' as constants;

class NewOrderPage extends StatefulWidget {
  const NewOrderPage(this.clientModel, this.eggPricesMap, {Key? key})
      : super(key: key);

  final ClientModel clientModel;
  final Map<String, dynamic> eggPricesMap;

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  late ClientModel clientModel;
  late Map<String, dynamic> valuesMap;
  late EggPricesData productPrices;
  bool showProgress = false;

  int step = 1;

  @override
  void initState() {
    super.initState();
    clientModel = widget.clientModel;
    valuesMap = widget.eggPricesMap;
    productPrices = EggPricesData(
        valuesMap['xl_box'],
        valuesMap['xl_dozen'],
        valuesMap['l_box'],
        valuesMap['l_dozen'],
        valuesMap['m_box'],
        valuesMap['m_dozen'],
        valuesMap['s_box'],
        valuesMap['s_dozen']);

    dateController.text = dateFormat.format(minDate);
    datePickerTimestamp = Timestamp.fromDate(minDate);
    step = 1;
  }

  TextEditingController dateController = TextEditingController();
  DateTime minDate = DateTime.now().add(const Duration(days: 3));

  List<String> productClasses = ["XL", "L", "M", "S"];
  Map<String, int> productQuantities = {};

  late String direction;
  String? paymentMethod;
  Timestamp? datePickerTimestamp;

  List<String> items = [];

  DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    if (items.isEmpty) {
      for (String key in constants.paymentMethod.keys) {
        items.add(key);
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: CustomColors.whiteColor,
            ),
            toolbarHeight: 56.0,
            title: const Text(
              'Nuevo pedido',
              style: TextStyle(fontSize: 18.0),
            )),
        body: showProgress
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Center(
                      child: showProgress
                          ? const CircularProgressIndicator()
                          : const SizedBox(),
                    ),
                  ),
                ],
              )
            : SafeArea(
                top: false,
                child: SingleChildScrollView(
                  child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            step == 2
                                ? Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 24),
                                        child: const Column(
                                          children: [
                                            Text(
                                              "Por favor, revise los datos que hay a continuación y pulse en el botón de 'CONFIRMAR' para formalizar el pedido.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              "Recuerde que una vez haya concluido el pedido, no se podrá modificar ni cancelar, salvo con causa justificada llamándonos directamente.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 1,
                                        color: CustomColors.redGraySecondaryColor,
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                children: [
                                  getAllFormElements(),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  getButtonComponent(),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ]
                              )
                            )
                            
                          ],
                        ),
                      )),
                ),
              ));
  }

  Widget getAllFormElements() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      getCompanyComponentSimpleForm('Dirección', null, TextInputType.text,
          clientModel.direction, false, true, true, (value) {
        direction = value;
      }, null),
      getComponentTableForm('Teléfono', getTelephoneTableRow()),
      getComponentTableWithSubtitlesForm('Pedido', getPricePerUnitTableRow()),
      const SizedBox(height: 16,),
      getCompanyComponentSimpleForm(
          'Método de pago',
          null,
          TextInputType.text,
          paymentMethod,
          step == 1 ? true : false,
          step == 1 ? false : true,
          false,
          (value) => {
                paymentMethod = value!,
              },
          null),
      getCompanyComponentSimpleForm(
          'Fecha de entrega',
          null,
          TextInputType.text,
          null,
          step == 1 ? true : false,
          true,
          true,
          null, () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: minDate,
            firstDate: minDate,
            lastDate: DateTime(
                DateTime.now().year + 1, DateTime.now().month, minDate.day));
        if (pickedDate != null) {
          setState(() {
            datePickerTimestamp = Timestamp.fromDate(pickedDate);
            dateController.text = dateFormat.format(pickedDate);
          });
        }
      }, textEditingController: dateController),
    ]);
  }

  Widget getCompanyComponentSimpleForm(
      String label,
      String? labelInputText,
      TextInputType textInputType,
      String? initialValue,
      bool isEnabled,
      bool isReadyOnly,
      bool isText,
      Function(dynamic)? onChange,
      Future<dynamic> Function()? onTap,
      {TextCapitalization textCapitalization = TextCapitalization.sentences,
      TextEditingController? textEditingController}) {
    double topMargin = 4;
    double bottomMargin = 4;

    if (isText) {
      return HNComponentSimpleForm(
        '$label:',
        8,
        40,
        const EdgeInsets.symmetric(horizontal: 16),
        EdgeInsets.only(
          top: topMargin,
          bottom: bottomMargin,
        ),
        componentTextInput: HNComponentTextInput(
          textCapitalization: textCapitalization,
          labelText: labelInputText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textInputType: textInputType,
          initialValue: initialValue,
          isEnabled: isEnabled,
          readOnly: isEnabled,
          onChange: onChange,
          onTap: onTap,
          textEditingController: textEditingController,
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      );
    } else {
      return step == 1
          ? HNComponentSimpleForm(
              '$label:',
              8,
              40,
              const EdgeInsets.symmetric(horizontal: 16),
              EdgeInsets.only(
                top: topMargin,
                bottom: bottomMargin,
              ),
              componentDropdown: HNComponentDropdown(
                items,
                initialValue: initialValue,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                textInputType: textInputType,
                isEnabled: isEnabled,
                onChange: onChange,
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )
          : HNComponentSimpleForm(
              '$label:',
              8,
              40,
              const EdgeInsets.symmetric(horizontal: 16),
              EdgeInsets.only(
                top: topMargin,
                bottom: bottomMargin,
              ),
              componentTextInput: HNComponentTextInput(
                textCapitalization: textCapitalization,
                labelText: labelInputText,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                textInputType: textInputType,
                initialValue: initialValue,
                isEnabled: isEnabled,
                readOnly: isEnabled,
                onChange: onChange,
                onTap: onTap,
                textEditingController: textEditingController,
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            );
    }
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
      "$label:",
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
              initialValue: clientModel.phone[0].keys.first,
              isEnabled: false,
            )),
        HNComponentCellTableForm(
            40, const EdgeInsets.only(left: 8, right: 16, bottom: 8),
            componentTextInput: HNComponentTextInput(
              textCapitalization: TextCapitalization.words,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              initialValue: clientModel.phone[0].values.first.toString(),
              isEnabled: false,
            )),
      ]),
    ];
  }

  List<Widget> getPricePerUnitTableRow() {
    List<Widget> list = [];


    for (var item in constants.productClasses) {

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
                    child: Text("Docena")),
                Container(
                  height: 40,
                  margin: const EdgeInsets.only(left: 8, right: 16, bottom: 0),
                  child: HNComponentTextInput(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    textInputType: const TextInputType.numberWithOptions(),
                    onChange: (value) {
                      String key = "${item.toLowerCase()}_dozen";
                      productQuantities[key] = int.tryParse(value) ?? 0;
                    },
                    isEnabled: step == 1 ? true : false,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 24, right: 16),
                    child: Text("${valuesMap["${item.toLowerCase()}_dozen"]} €")),
              ]
            ),
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
                    onChange: (value) {
                      String key = "${item.toLowerCase()}_box";
                      productQuantities[key] = int.tryParse(value) ?? 0;
                    },
                    isEnabled: step == 1 ? true : false,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 24, right: 16),
                    child: Text("${valuesMap["${item.toLowerCase()}_box"]} €")),
              ]
            )
          ],
        )
      );
    }

    return list;
  }

  Widget getClientComponentSimpleForm(
      String label, TextInputType textInputType, Function(String)? onChange,
      {TextEditingController? controller}) {
    double topMargin = 4;
    double bottomMargin = 4;

    return HNComponentSimpleForm(
      '$label:',
      8,
      40,
      const EdgeInsets.only(left: 0),
      EdgeInsets.only(top: topMargin, bottom: bottomMargin),
      componentTextInput: HNComponentTextInput(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textCapitalization: TextCapitalization.none,
        textInputType: textInputType,
        onChange: onChange,
        textEditingController: controller,
      ),
      textMargin: const EdgeInsets.only(left: 24),
    );
  }

  Widget getButtonComponent() {
    return Column(
      children: [
        HNButton(ButtonTypes.redWhiteBoldRoundedButton).getTypedButton(
            step == 1 ? "GUARDAR" : "CONFIRMAR", null, null, () async {
          if (checkFields()) {
            if (step == 1) {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: const Text('Aviso'),
                        content: const Text(
                            'Una vez realizado el pedido, no se podrán modificar los datos directamente. Tendrá que llamarnos y solicitar el cambio. ¿Desea continuar o prefiere revisar los datos?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Revisar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Continuar'),
                            onPressed: () {
                              setState(() {
                                step = 2;
                              });
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ));
            } else if (step == 2) {
              FocusManager.instance.primaryFocus?.unfocus();
              showAlertDialog(context);

              int newId = await FirebaseUtils.instance
                  .getNewOrderId(clientModel.doocumentId);
              DBOrderFieldData dbOrderFieldData =
                  Utils().getOrderStructure(productQuantities, productPrices);
              double totalPrice =
                  Utils().roundDouble(getTotalPrice(dbOrderFieldData), 2);
              if (context.mounted) {
                Navigator.of(context).pop();
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: const Text('Precio final'),
                          content: Text(
                              'El precio total del pedido será de $totalPrice €. ¿Desea continuar?'),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Atrás")),
                            TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  showAlertDialog(context);

                                  OrderModel orderModel = OrderModel(
                                      datePickerTimestamp!,
                                      clientModel.id,
                                      clientModel.company,
                                      "client_${clientModel.id}",
                                      null,
                                      null,
                                      null,
                                      null,
                                      null,
                                      null,
                                      dbOrderFieldData.toMap(),
                                      Timestamp.now(),
                                      newId,
                                      false,
                                      Utils().paymentMethodStringToInt(
                                          paymentMethod ?? ""),
                                      1,
                                      totalPrice,
                                      null);
                                  bool conf = await FirebaseUtils.instance
                                      .saveNewOrder(
                                          clientModel.doocumentId, orderModel);
                                  if (conf) {
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                                title: const Text(
                                                    "Pedido realizado"),
                                                content: const Text(
                                                    "Su pedido se ha realizado correctamente."),
                                                actions: <Widget>[
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.pop(context);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (_) =>
                                                                    MyOrdersPage(
                                                                        clientModel,
                                                                        true)));
                                                      },
                                                      child: const Text(
                                                          "De acuerdo"))
                                                ],
                                              ));
                                    }
                                  } else {
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                                title: const Text(
                                                    'Se ha producido un error'),
                                                content: const Text(
                                                    'Sentimos comunicarle que se ha producido un error inesperado durante el pedido. Por favor, inténtelo más tarde o póngase en contacto con nosotros.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text(
                                                        'De acuerdo'),
                                                    onPressed: () async {
                                                      dispose();
                                                    },
                                                  ),
                                                ],
                                              ));
                                    }
                                  }
                                },
                                child: const Text("Continuar")),
                          ],
                        ));
              }
            }
          } else {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: const Text('Formulario incorrecto'),
                      content: const Text(
                          'Por favor, compruebe los datos. Hay errores o faltan campos por rellenar.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('De acuerdo'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ));
          }
          setState(() {
            showProgress = false;
          });
        }, () {}),
        step == 2
            ? Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  HNButton(ButtonTypes.redWhiteBoldRoundedButton)
                      .getTypedButton("Modificar datos", null, null, () {
                    setState(() {
                      step = 1;
                    });
                  }, () {}),
                ],
              )
            : const SizedBox()
      ],
    );
  }

  bool checkFields() {
    if (paymentMethod != null && datePickerTimestamp != null && isOrder()) {
      return true;
    } else {
      return false;
    }
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  bool isOrder() {
    if ((productQuantities.containsKey("xl_box") &&
            productQuantities["xl_box"] != 0) ||
        (productQuantities.containsKey("xl_dozen") &&
            productQuantities["xl_dozen"] != 0) ||
        (productQuantities.containsKey("l_box") &&
            productQuantities["l_box"] != 0) ||
        (productQuantities.containsKey("l_dozen") &&
            productQuantities["l_dozen"] != 0) ||
        (productQuantities.containsKey("m_box") &&
            productQuantities["m_box"] != 0) ||
        (productQuantities.containsKey("m_dozen") &&
            productQuantities["m_dozen"] != 0) ||
        (productQuantities.containsKey("s_box") &&
            productQuantities["s_box"] != 0) ||
        (productQuantities.containsKey("s_dozen") &&
            productQuantities["s_dozen"] != 0)) {
      return true;
    } else {
      return false;
    }
  }

  double getTotalPrice(DBOrderFieldData dbOrderFieldData) {
    double totalPrice = 0.0;

    if (dbOrderFieldData.xlBoxQuantity != null &&
        dbOrderFieldData.xlBoxPrice != null) {
      totalPrice += (dbOrderFieldData.xlBoxQuantity as int) *
          (dbOrderFieldData.xlBoxPrice!.toDouble());
    }
    if (dbOrderFieldData.xlDozenQuantity != null &&
        dbOrderFieldData.xlDozenPrice != null) {
      totalPrice += (dbOrderFieldData.xlDozenQuantity as int) *
          (dbOrderFieldData.xlDozenPrice!.toDouble());
    }
    if (dbOrderFieldData.lBoxQuantity != null &&
        dbOrderFieldData.lBoxPrice != null) {
      totalPrice += (dbOrderFieldData.lBoxQuantity as int) *
          (dbOrderFieldData.lBoxPrice!.toDouble());
    }
    if (dbOrderFieldData.lDozenQuantity != null &&
        dbOrderFieldData.lDozenPrice != null) {
      totalPrice += (dbOrderFieldData.lDozenQuantity as int) *
          (dbOrderFieldData.lDozenPrice!.toDouble());
    }
    if (dbOrderFieldData.mBoxQuantity != null &&
        dbOrderFieldData.mBoxPrice != null) {
      totalPrice += (dbOrderFieldData.mBoxQuantity as int) *
          (dbOrderFieldData.mBoxPrice!.toDouble());
    }
    if (dbOrderFieldData.mDozenQuantity != null &&
        dbOrderFieldData.mDozenPrice != null) {
      totalPrice += (dbOrderFieldData.mDozenQuantity as int) *
          (dbOrderFieldData.mDozenPrice!.toDouble());
    }
    if (dbOrderFieldData.sBoxQuantity != null &&
        dbOrderFieldData.sBoxPrice != null) {
      totalPrice += (dbOrderFieldData.sBoxQuantity as int) *
          (dbOrderFieldData.sBoxPrice!.toDouble());
    }
    if (dbOrderFieldData.sDozenQuantity != null &&
        dbOrderFieldData.sDozenPrice != null) {
      totalPrice += (dbOrderFieldData.sDozenQuantity as int) *
          (dbOrderFieldData.sDozenPrice!.toDouble());
    }
    return totalPrice;
  }
}
