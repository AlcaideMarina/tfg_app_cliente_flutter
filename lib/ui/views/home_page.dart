import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/model/client_model.dart';

import '../../custom/app_theme.dart';
import '../../values/strings_translation.dart';

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
        title: Text(
          StringsTranslation.of(context)
            ?.translate('hueveria_nieto') ?? "Huevería nieto", 
          style: const TextStyle(
            color: AppTheme.primary,
            fontSize: 24.0
          ),
        )
      ),
    );
  }
}