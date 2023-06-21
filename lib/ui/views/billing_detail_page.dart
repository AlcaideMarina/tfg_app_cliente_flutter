import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/custom/custom_colors.dart';
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
              color: CustomColors.whiteColor,
            ),
            toolbarHeight: 56.0,
            title: const Text(
              'Facturación',
              style: TextStyle(fontSize: 18.0),
            )),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              isCurrentMonth
                  ? Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        child: const Text(
                          "Esta factura es del mes vigente, por lo que no es una versión definitiva.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontStyle: FontStyle.italic
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: CustomColors.redPrimaryColor,
                      ),
                    ])
                  : const SizedBox(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Pagos al contado:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "${Utils().roundDouble(billingData.paymentByCash, 2).toString()} €",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Pagos por recibo:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),),
                        Text(
                          "${Utils().roundDouble(billingData.paymentByReceipt, 2).toString()} €",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),)
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Pagos por transferencia:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),),
                        Text(
                          "${Utils().roundDouble(billingData.paymentByTransfer, 2).toString()} €",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),)
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Pagado hasta ahora:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),),
                        Text(
                          "${Utils().roundDouble(billingData.paid, 2).toString()} €",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),)
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Pendiente de pago:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),),
                        Text(
                          "${Utils().roundDouble(billingData.toBePaid, 2).toString()} €",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),)
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: CustomColors.redGrayLightSecondaryColor,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "PAGO TOTAL:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                    Text(
                      "${Utils().roundDouble(billingData.totalPrice, 2).toString()} €",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),)
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: CustomColors.redGrayLightSecondaryColor,
              ),
            ],
          ),
        ));
  }
}
