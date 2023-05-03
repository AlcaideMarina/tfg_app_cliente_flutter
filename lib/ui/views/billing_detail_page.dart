import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/model/billing_data.dart';

import '../../custom/app_theme.dart';

class BillingDetailPage extends StatefulWidget {
  const BillingDetailPage(this.billingData, this.isCurrentMonth, {Key? key}) : super(key: key);

  final BillingData billingData;
  final bool isCurrentMonth;

  @override
  State<BillingDetailPage> createState() => _BillingDetailPageState();
}

class _BillingDetailPageState extends State<BillingDetailPage> {
  late BillingData billingData;
  late bool isCurrentMonth;
  void initState() {
    super.initState();
    billingData = widget.billingData;
    isCurrentMonth = widget.isCurrentMonth;
  }

  @override
  Widget build(BuildContext context) {
    
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
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Column(
            children: [
              // TODO: Ocultar este texto cuando corresponda
              isCurrentMonth ? const Column(
                children: [
                  Text("Esta factura es del mes vigente, por lo que no es una versión definitiva."),
                  SizedBox(
                    height: 16,
                  ),
                ]
              ) : const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pagos al contado:"),
                  Text("${billingData.paymentByCash.toString()} €")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pagos por recibo:"),
                  Text("${billingData.paymentByReceipt.toString()} €")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pagos por transferencia:"),
                  Text("${billingData.paymentByTransfer.toString()} €")
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pagado hasta ahora:"),
                  Text("${billingData.paid.toString()} €")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pendiente de pago:"),
                  Text("${billingData.toBePaid.toString()} €")
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pago total:"),
                  Text("${billingData.totalPrice.toString()} €")
                ],
              ),
            ],
          ),
        )
    );
  }
}
