import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/model/billing_data.dart';
import 'package:hueveria_nieto_clientes/values/utils.dart';

import '../../custom/app_theme.dart';

class BillingDetailPage extends StatefulWidget {
  const BillingDetailPage(this.billingData, this.isCurrentMonth, {Key? key})
      : super(key: key);

  final BillingData billingData;
  final bool isCurrentMonth;

  @override
  State<BillingDetailPage> createState() => _BillingDetailPageState();
}

class _BillingDetailPageState extends State<BillingDetailPage> {
  late BillingData billingData;
  late bool isCurrentMonth;
  @override
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
              color: Colors.black,
            ),
            toolbarHeight: 56.0,
            title: const Text(
              'Facturación',
              style: TextStyle(color: AppTheme.primary, fontSize: 24.0),
            )),
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Column(
            children: [
              isCurrentMonth
                  ? const Column(children: [
                      Text(
                          "Esta factura es del mes vigente, por lo que no es una versión definitiva."),
                      SizedBox(
                        height: 16,
                      ),
                    ])
                  : const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pagos al contado:"),
                  Text(
                      "${Utils().roundDouble(billingData.paymentByCash, 2).toString()} €")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pagos por recibo:"),
                  Text(
                      "${Utils().roundDouble(billingData.paymentByReceipt, 2).toString()} €")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pagos por transferencia:"),
                  Text(
                      "${Utils().roundDouble(billingData.paymentByTransfer, 2).toString()} €")
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pagado hasta ahora:"),
                  Text(
                      "${Utils().roundDouble(billingData.paid, 2).toString()} €")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pendiente de pago:"),
                  Text(
                      "${Utils().roundDouble(billingData.toBePaid, 2).toString()} €")
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pago total:"),
                  Text(
                      "${Utils().roundDouble(billingData.totalPrice, 2).toString()} €")
                ],
              ),
            ],
          ),
        ));
  }
}
