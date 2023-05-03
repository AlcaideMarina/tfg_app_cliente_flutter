import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/model/billing_data.dart';

import '../../custom/app_theme.dart';

class BillingDetailPage extends StatefulWidget {
  const BillingDetailPage(this.billingData, {Key? key}) : super(key: key);

  final BillingData billingData;

  @override
  State<BillingDetailPage> createState() => _BillingDetailPageState();
}

class _BillingDetailPageState extends State<BillingDetailPage> {
  late BillingData billingData;
  void initState() {
    super.initState();
    billingData = widget.billingData;
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
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              // TODO: Ocultar este texto cuando corresponda
              Text("Esta factura es del mes vigente, por lo que no es una versión definitiva."),
              SizedBox(
                height: 16,
              )
            ],
          ),
        )
    );
  }
}
