import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/custom/custom_colors.dart';
import 'package:hueveria_nieto_clientes/firebase/firebase_utils.dart';
import 'package:hueveria_nieto_clientes/model/client_model.dart';
import 'package:hueveria_nieto_clientes/model/db_order_field_data.dart';
import 'package:hueveria_nieto_clientes/model/order_model.dart';
import 'package:hueveria_nieto_clientes/ui/components/component_dropdown.dart';
import 'package:hueveria_nieto_clientes/ui/views/my_orders_page.dart';
import 'package:hueveria_nieto_clientes/ui/views/my_profile.dart';
import 'package:hueveria_nieto_clientes/values/utils.dart';
import 'package:intl/intl.dart';

import '../../custom/app_theme.dart';
import '../components/component_cell_table_form.dart';
import '../components/component_simple_form.dart';
import '../components/component_table_form.dart';
import '../components/component_text_input.dart';
import '../components/constants/hn_button.dart';
import 'package:hueveria_nieto_clientes/values/constants.dart' as constants;


class NewOrderPage extends StatefulWidget {
  const NewOrderPage(this.clientModel, {Key? key}) : super(key: key);

  final ClientModel clientModel;

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

// TODO: Faltan todas las validaciones
class _NewOrderPageState extends State<NewOrderPage> {
  late ClientModel clientModel;
  bool showProgress = false;

  int step = 1;

  @override
  void initState() {
    super.initState();
    clientModel = widget.clientModel;
    dateController.text = dateFormat.format(minDate);
    datePickerTimestamp = Timestamp.fromDate(minDate);
    step = 1;
  }

  TextEditingController dateController = TextEditingController();
  DateTime minDate = DateTime.now().add(const Duration(days: 3));

  // TODO: Esto se tiene que sacar de las constantes
  List<String> productClasses = ["XL", "L", "M", "S"];
  Map<String, int> productQuantities = {}; 

  late String direction;
  String? paymentMethod;
  Timestamp? datePickerTimestamp;

  // TODO: Esto se tiene que sacar de las constantes
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
              color: Colors.black, //change your color here
            ),
            toolbarHeight: 56.0,
            title: const Text(
              'Nuevo pedido',
              style: TextStyle(
                  color: AppTheme.primary, fontSize: 24.0),
            )),
        body: showProgress ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Center(
                        // use ternary operator to decide when to show progress indicator
                        child: showProgress
                            ? const CircularProgressIndicator()
                            : const SizedBox(),
                      ),
                    ),
                  ],
                ) : SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      step == 2 ? const Column(
                        children: [
                          Text(
                            "Por favor, revise los datos que hay a continuación y pulse en el botón de 'CONFIRMAR' para formalizar el pedido.",
                            textAlign: TextAlign.center,),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Recuerde que una vez haya concluido el pedido, no se podrá modificar ni cancelar, salvo con causa justificada llamándonos directamente.",
                            textAlign: TextAlign.center,),
                          SizedBox(
                            height: 32,
                          ),
                        ],
                      ) : const SizedBox(),
                      getAllFormElements(),
                      const SizedBox(
                        height: 32,
                      ),
                      getButtonComponent(),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCompanyComponentSimpleForm('Dirección', null, TextInputType.text, 
          clientModel.direction, false, true, true,
          (value) {
            direction = value;
          }, null),
        getComponentTableForm('Teléfono', getTelephoneTableRow()),
        getComponentTableForm('Pedido', getPricePerUnitTableRow()),
        // TODO: Esto no se inhabilita en el segundo paso
        getCompanyComponentSimpleForm('Método de pago', null, TextInputType.text, 
          null, step == 1 ? true : false, step == 1 ? false : true, false,
          (value) => {
            paymentMethod = value!,
          }, null),
        getCompanyComponentSimpleForm('Fecha de entrega', null, TextInputType.text, 
          null, step == 1 ? true : false, true, true, null,
          () async {
            // TODO: Cambiar el color
            DateTime? pickedDate = await showDatePicker(
              context: context, 
              initialDate: minDate, 
              firstDate: minDate, 
              lastDate: DateTime(
                DateTime.now().year + 1,
                DateTime.now().month,
                minDate.day
              )
            );
            if (pickedDate != null) {
              setState(() {
                datePickerTimestamp = Timestamp.fromDate(pickedDate);
                dateController.text = dateFormat.format(pickedDate);
              });
            }
          },
          textEditingController: dateController),
      ]
    );
  }

  Widget getCompanyComponentSimpleForm(String label, String? labelInputText,
      TextInputType textInputType, String? initialValue, bool isEnabled, bool isReadyOnly, bool isText,
      Function(dynamic)? onChange, Future<dynamic> Function()? onTap, 
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
        EdgeInsets.only(top: topMargin, bottom: bottomMargin,),
        componentTextInput: 
          HNComponentTextInput(
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
        );
    } else {
      return HNComponentSimpleForm(
        '$label:',
        8,
        40,
        const EdgeInsets.symmetric(horizontal: 16),
        EdgeInsets.only(top: topMargin, bottom: bottomMargin,),
        componentDropdown: 
          HNComponentDropdown(
            items,
            labelText: labelInputText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            textInputType: textInputType,
            isEnabled: isEnabled,
            onChange: onChange,
          ),
        );
    }

    
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
              initialValue: clientModel.phone[0].keys.first,
              isEnabled: false,
            )),
        HNComponentCellTableForm(
            40,
            const EdgeInsets.only(left: 8, right: 16, bottom: 8),
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

  List<TableRow> getPricePerUnitTableRow() {
    List<TableRow> list = [];

    for (var item in productClasses) {
      list.add(
        TableRow(
          children: [
            Container(
              child: Text(item),
              margin: const EdgeInsets.only(left: 12, right: 16),
            ),
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
                onChange: (value) {
                  String key = "${item.toLowerCase()}_dozen";
                  productQuantities[key] = int.parse(value);
                },
                isEnabled: step == 1 ? true : false,
              ),
            ),
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
                onChange: (value) {
                  // TODO: Fix - Aquí hay que meter una validación para comprobar que el input se pueda pasar a double
                  String key = "${item.toLowerCase()}_box";
                  productQuantities[key] = int.parse(value);
                },
                isEnabled: step == 1 ? true : false,
              ),
            ),
          ]
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
      label + ':',
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
    return Column(children: [
      HNButton(ButtonTypes.redWhiteBoldRoundedButton).getTypedButton(
        step == 1 ? "GUARDAR" : "CONFIRMAR", null, null, () async { 
          setState(() {
            showProgress = true;
          });
          if (checkFields()) {
            if (step == 1) {
              showDialog(
                context: context, 
                builder: (_) => AlertDialog(
                  title: const Text('Aviso'),
                  content: const Text('Una vez realizado el pedido, no se podrán modificar los datos directamente. Tendrá que llamarnos y solicitar el cambio. ¿Desea continuar o prefiere revisar los datos?'),
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
                        //Subir scroll
                      },
                    )
                  ],
                ));
            } else if (step == 2) {
              int newId = await FirebaseUtils.instance.getNewOrderId(clientModel.doocumentId);
              OrderModel orderModel = OrderModel(
                datePickerTimestamp!, 
                clientModel.id.toString(), 
                null, 
                null, 
                null, 
                null, 
                null, 
                getOrderStructure().toMap(), 
                Timestamp.now(), 
                newId, 
                false, 
                Utils().paymentMethodStringToInt(paymentMethod ?? ""), 
                0, 
                null);
                bool conf = await FirebaseUtils.instance.saveNewOrder(clientModel.doocumentId, orderModel);
                if (conf) {
                  if (context.mounted) {
                    showDialog(
                      context: context, 
                      builder: (_) => AlertDialog(
                        title: const Text("Pedido realizado"),
                        content: const Text("Su pedido se ha realizado correctamente. En un plazo máximo de 24 horas, nos pondremos en contacto con usted para confirmar los datos. ¡Gracias por la confianza!"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(this.context).pop();
                    Navigator.pop(context);
                    // TODO: Cambiar esto - ahora debería ir a ver todos los pedidos, con un flag que indique que tiene que mostrar el popup
                    Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MyOrdersPage(clientModel, true)));
                            }, 
                            child: const Text("De acuerdo")
                          )
                        ],
                      ));
                  }
                } else {
                  if (context.mounted) {
                    showDialog(
                      context: context, 
                      builder: (_) => AlertDialog(
                        title: const Text('Se ha producido un error'),
                        content: const Text('Sentimos comunicarle que se ha producido un error inesperado durante el pedido. Por favor, inténtelo más tarde o póngase en contacto con nosotros.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('De acuerdo'),
                            onPressed: () async {
                              dispose();
                            },
                          ),
                        ],
                      )
                    );
                  }
                }
            }
          } else {
            showDialog(
                context: context, 
                builder: (_) => AlertDialog(
                  title: const Text('Formulario incorrecto'),
                  content: const Text('Por favor, compruebe los datos. Hay errores o faltan campos por rellenar.'),
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
        }, () { }
      ),
      step == 2 ? Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          HNButton(ButtonTypes.redWhiteBoldRoundedButton).getTypedButton(
            "Modificar datos", null, null, () { }, () { }),
        ],
      ) : const SizedBox()
      
    ],);
  }

  bool checkFields() {
    if (paymentMethod != null && datePickerTimestamp != null && isOrder()) {
      return true;
    } else {
      return false;
    }
  }

  bool isOrder() {
    if ((productQuantities.containsKey("xl_box") && productQuantities["xl_box"] != 0) || 
        (productQuantities.containsKey("xl_dozen") && productQuantities["xl_dozen"] != 0) || 
        (productQuantities.containsKey("l_box") && productQuantities["l_box"] != 0) || 
        (productQuantities.containsKey("l_dozen") && productQuantities["l_dozen"] != 0) || 
        (productQuantities.containsKey("m_box") && productQuantities["m_box"] != 0) || 
        (productQuantities.containsKey("m_dozen") && productQuantities["m_dozen"] != 0) || 
        (productQuantities.containsKey("s_box") && productQuantities["s_box"] != 0) || 
        (productQuantities.containsKey("s_dozen") && productQuantities["s_dozen"] != 0)) {
      return true;
    } else {
      return false;
    }
  }

  DBOrderFieldData getOrderStructure() {
    int xlBox = 0;
    int xlDozen = 0;
    int lBox = 0;
    int lDozen = 0;
    int mBox = 0;
    int mDozen = 0;
    int sBox = 0;
    int sDozen = 0;

    if (productQuantities.containsKey("xl_box") && productQuantities['xl_box'] != null){
      xlBox = productQuantities['xl_box']!;
    }
    if (productQuantities.containsKey("xl_dozen") && productQuantities['xl_dozen'] != null){
      xlDozen = productQuantities['xl_dozen']!;
    }
    if (productQuantities.containsKey("l_box") && productQuantities['l_box'] != null){
      lBox = productQuantities['l_box']!;
    }
    if (productQuantities.containsKey("l_dozen") && productQuantities['l_dozen'] != null){
      lDozen = productQuantities['l_dozen']!;
    }
    if (productQuantities.containsKey("m_box") && productQuantities['m_box'] != null){
      mBox = productQuantities['m_box']!;
    }
    if (productQuantities.containsKey("m_dozen") && productQuantities['m_dozen'] != null){
      mDozen = productQuantities['m_dozen']!;
    }
    if (productQuantities.containsKey("s_box") && productQuantities['s_box'] != null){
      sBox = productQuantities['s_box']!;
    }
    if (productQuantities.containsKey("s_dozen") && productQuantities['s_dozen'] != null){
      sDozen = productQuantities['s_dozen']!;
    }

    return DBOrderFieldData(
      null,
      xlBox,
      null,
      xlDozen,
      null,
      lBox,
      null,
      lDozen,
      null,
      mBox,
      null,
      mDozen,
      null,
      sBox,
      null,
      sDozen,
    );
  }
}
