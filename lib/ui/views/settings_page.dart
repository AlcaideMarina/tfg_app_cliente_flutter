import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/custom/custom_colors.dart';

import '../../custom/app_theme.dart';
import '../../model/client_model.dart';
import 'change_password_page.dart';

class SettingsPage extends StatefulWidget {

  final ClientModel clientModel;

  const SettingsPage(this.clientModel, {Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ClientModel clientModel;

  @override
  void initState() {
    super.initState();
    clientModel = widget.clientModel;
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
              'Ajustes',
              style: TextStyle(
                  color: AppTheme.primary, fontSize: 24.0),
            )),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: CustomColors.redPrimaryColor,
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      width: double.infinity,
                      child: Column(
                        children: [
                          const SizedBox(width: double.infinity, child: Text("CONTACTO")),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: const Column(
                              children: [
                                SizedBox(width: double.infinity, child: Text("Dirección: Calle MAtadero 80, Bajo - 15002, A Coruña")),
                                SizedBox(
                                  height: 8,
                                ),
                                SizedBox(width: double.infinity, child: Text("Teléfono: 981204709  -  981209405")),
                                SizedBox(
                                  height: 8,
                                ),
                                SizedBox(width: double.infinity, child: Text("Correo: hueverianieto@gmail.com"))
                              ]
                            ),
                          )
                        ],
                      ),
                    )
                  ]
                ),
              )
            ),
            ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  ListTile(
                    title: Text('Cambiar contraseña', style: TextStyle(fontSize: 15),), 
                    dense: true, 
                    onTap: () {
                      navigateToChangePassword();
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: Text('Cambiar idioma', style: TextStyle(fontSize: 15),), 
                    dense: true, 
                    onTap: () {},
                  ),
                ],
          ),
          ],
              
    ));
  }

  navigateToChangePassword() {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: ((context) => ChangePasswordPage(clientModel))));
  }
}
