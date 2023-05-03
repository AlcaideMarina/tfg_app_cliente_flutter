import 'package:flutter/material.dart';

import '../../custom/app_theme.dart';
import '../../model/client_model.dart';

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
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            ListTile(
              title: Text('Cambiar contraseña', style: TextStyle(fontSize: 15),), 
              dense: true, 
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: Text('Cambiar idioma', style: TextStyle(fontSize: 15),), 
              dense: true, 
              onTap: () {},
            ),
          ],
        )
    );
  }
}
