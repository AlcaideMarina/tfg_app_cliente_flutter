import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/custom/custom_colors.dart';
import 'package:hueveria_nieto_clientes/ui/views/billing_page.dart';
import 'package:hueveria_nieto_clientes/ui/views/my_orders_page.dart';
import 'package:hueveria_nieto_clientes/ui/views/my_profile.dart';
import 'package:hueveria_nieto_clientes/ui/views/new_order_page.dart';
import 'package:hueveria_nieto_clientes/ui/views/settings_page.dart';
import 'package:hueveria_nieto_clientes/values/constants.dart';

import '../../model/client_model.dart';
import '../../values/image_routes.dart';

class SingleTableCard extends StatelessWidget {
  final IconData icono;
  final Color color;
  final HomeMenuOptions homeMenuOption;
  final String id;
  final SingleTableCardPositions position;
  final ClientModel clientModel;

  const SingleTableCard(
      this.icono,
      this.color,
      this.homeMenuOption,
      this.id,
      this.position,
      this.clientModel,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final homeMenuOptionStr = mapHomeMenuOptions[homeMenuOption];

    return Container(
      margin: position == SingleTableCardPositions.leftPosition 
        ? const EdgeInsets.fromLTRB(16, 8, 8, 8) 
        : position == SingleTableCardPositions.rightPosition 
          ? const EdgeInsets.fromLTRB(8, 8, 16, 8)
          : const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: GestureDetector(
              child: Container(
                  height: 176,
                  decoration: BoxDecoration(
                      color: CustomColors.redPrimaryColor,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageRoutes.getRoute('ic_logo'),
                          width: 104, height: 104),
                        SizedBox(height: 10.0),
                        Text(
                          homeMenuOptionStr ?? "",
                          style: const TextStyle(
                              color: CustomColors.redGraySecondaryColor, 
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ])),
              onTap: () {
                if (homeMenuOption == HomeMenuOptions.myProfile) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyProfilePage(clientModel),
                    ));
                }
                if (homeMenuOption == HomeMenuOptions.billing) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BillingPage(clientModel),
                    ));
                }
                if (homeMenuOption == HomeMenuOptions.myOrders) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyOrdersPage(clientModel, false),
                    ));
                }
                if (homeMenuOption == HomeMenuOptions.newOrder) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewOrderPage(clientModel),
                    ));
                }
                if (homeMenuOption == HomeMenuOptions.settings) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(clientModel),
                    ));
                }
              },
            )),
      ),
    );
  }
}