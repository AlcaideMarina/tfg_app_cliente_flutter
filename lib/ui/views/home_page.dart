import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/custom/custom_colors.dart';
import 'package:hueveria_nieto_clientes/model/client_model.dart';
import 'package:hueveria_nieto_clientes/values/constants.dart';
import 'package:hueveria_nieto_clientes/values/image_routes.dart';

import '../../custom/app_theme.dart';
import '../components/component_single_table_card.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage(this.clientModel, {Key? key}) : super(key: key);

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
        toolbarHeight: 56.0,
        title: const Text(
          "Home",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Image.asset(ImageRoutes.getRoute('ic_logout'), width: 24, height: 24,),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: const Text('Aviso'),
                        content:
                            Text("¿Está seguro de que quiere cerrar sesión?"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cancelar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Continuar'),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await FirebaseAuth.instance.signOut();
                              navegateToLogin();
                            },
                          )
                        ],
                      ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Table(
                children: [
                  TableRow(children: [
                    SingleTableCard(
                        Icons.person_outline_outlined,
                        CustomColors.blackColor,
                        HomeMenuOptions.myProfile,
                        clientModel.id.toString(),
                        SingleTableCardPositions.leftPosition,
                        clientModel),
                    SingleTableCard(
                        Icons.person_outline_outlined,
                        CustomColors.blackColor,
                        HomeMenuOptions.billing,
                        clientModel.id.toString(),
                        SingleTableCardPositions.rightPosition,
                        clientModel)
                  ]),
                  TableRow(children: [
                    SingleTableCard(
                        Icons.person_outline_outlined,
                        CustomColors.blackColor,
                        HomeMenuOptions.myOrders,
                        clientModel.id.toString(),
                        SingleTableCardPositions.leftPosition,
                        clientModel),
                    SingleTableCard(
                        Icons.person_outline_outlined,
                        CustomColors.blackColor,
                        HomeMenuOptions.newOrder,
                        clientModel.id.toString(),
                        SingleTableCardPositions.rightPosition,
                        clientModel)
                  ]),
                ],
              ),
            ),
            SizedBox(
              width: _width / 2 - 16,
              child: SingleTableCard(
                  Icons.person_outline_outlined,
                  CustomColors.blackColor,
                  HomeMenuOptions.settings,
                  clientModel.id.toString(),
                  SingleTableCardPositions.centerPosition,
                  clientModel),
            )
          ],
        ),
      ),
    );
  }

  navegateToLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: ((context) => const LoginPage())));
  }
}
