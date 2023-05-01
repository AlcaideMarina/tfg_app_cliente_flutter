import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/custom/custom_colors.dart';
import 'package:hueveria_nieto_clientes/model/client_model.dart';
import 'package:hueveria_nieto_clientes/values/constants.dart';

import '../../custom/app_theme.dart';
import '../../values/strings_translation.dart';
import '../components/component_single_table_card.dart';

class HomePage extends StatefulWidget {
  HomePage(this.clientModel, {Key? key}) : super(key: key);

  final ClientModel clientModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late ClientModel clientModel;

  @override
  void initState() {
    super.initState();
    clientModel = widget.clientModel;
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        //leading: const Icon(Icons.menu_rounded, color: AppTheme.primary,),
        toolbarHeight: 56.0,
        title: const Text(
          "Home", 
          style: TextStyle(
            color: AppTheme.primary,
            fontSize: 24.0
          ),
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Table(
              children: [
                TableRow(children: [
                  SingleTableCard(
                    Icons.person_outline_outlined,
                    CustomColors.blackColor,
                    HomeMenuOptions.myProfile,
                    clientModel.id,
                    SingleTableCardPositions.leftPosition,
                    clientModel
                  ),
                  SingleTableCard(
                    Icons.person_outline_outlined,
                    CustomColors.blackColor,
                    HomeMenuOptions.billing,
                    clientModel.id,
                    SingleTableCardPositions.rightPosition,
                    clientModel
                  )
                ]),
                TableRow(children: [
                  SingleTableCard(
                    Icons.person_outline_outlined,
                    CustomColors.blackColor,
                    HomeMenuOptions.myOrders,
                    clientModel.id,
                    SingleTableCardPositions.leftPosition,
                    clientModel
                  ),
                  SingleTableCard(
                    Icons.person_outline_outlined,
                    CustomColors.blackColor,
                    HomeMenuOptions.newOrder,
                    clientModel.id,
                    SingleTableCardPositions.rightPosition,
                    clientModel
                  )
                ]),
              ],
            ),
            SizedBox(
              width: _width/2 -16,
              child: SingleTableCard(
                Icons.person_outline_outlined,
                CustomColors.blackColor,
                HomeMenuOptions.settings,
                clientModel.id,
                SingleTableCardPositions.centerPosition,
                clientModel
              ),
            )
          ],
        ),
      ),
    );
  }
}