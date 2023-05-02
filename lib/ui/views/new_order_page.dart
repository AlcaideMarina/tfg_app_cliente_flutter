import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/custom/custom_colors.dart';
import 'package:hueveria_nieto_clientes/model/client_model.dart';
import 'package:hueveria_nieto_clientes/ui/components/component_dropdown.dart';
import 'package:intl/intl.dart';

import '../../custom/app_theme.dart';
import '../components/component_cell_table_form.dart';
import '../components/component_simple_form.dart';
import '../components/component_table_form.dart';
import '../components/component_text_input.dart';
import '../components/constants/hn_button.dart';

class NewOrderPage extends StatefulWidget {
  const NewOrderPage(this.clientModel, {Key? key}) : super(key: key);

  final ClientModel clientModel;

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

// TODO: Faltan todas las validaciones
class _NewOrderPageState extends State<NewOrderPage> {
  late ClientModel clientModel;

  @override
  void initState() {
    super.initState();
    clientModel = widget.clientModel;
    dateController.text = dateFormat.format(minDate);
  }

  TextEditingController dateController = TextEditingController();
  DateTime minDate = DateTime.now().add(const Duration(days: 3));

  // TODO: Esto se tiene que sacar de las constantes
  List<String> productClasses = ["XL", "L", "M", "S"];
  Map<String, double> productQuantities = {}; 

  late String direction;
  late String paymentMethod;

  // TODO: Esto se tiene que sacar de las constantes
  var items = [    
    'Al contado',
    'Por recibo',
    'Por transferencia',
  ];

  DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Por favor, revise los datos que hhya a continuación y pulse en el botón de 'CONFIRMAR' para formalizar el pedido.",
                        textAlign: TextAlign.center,),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Recuerde que una vez haya concluido el pedido, no se podrá modificar ni cancelar, salvo con causa justificada llamándonos directamente.",
                        textAlign: TextAlign.center,),
                      const SizedBox(
                        height: 32,
                      ),
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
        getCompanyComponentSimpleForm('Método de pago', null, TextInputType.text, 
          null, true, false, false,
          (value) => {
            paymentMethod = value!,
          }, null),
        getCompanyComponentSimpleForm('Fecha de entrega', null, TextInputType.text, 
          null, true, true, true, null,
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
                  // TODO: Fix - Aquí hay que meter una validación para comprobar que el input se pueda pasar a double
                  String key = "${item}_dozen";
                  productQuantities[key] = double.parse(value);
                },
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
                  String key = "${item}_box";
                  productQuantities[key] = double.parse(value);
                },
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
        "GUARDAR", null, null, () { }, () { }),
    ],);
  }
  
}
