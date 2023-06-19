import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hueveria_nieto_clientes/custom/custom_colors.dart';
import 'dart:developer' as developer;

import '../../firebase/firebase_utils.dart';
import '../../model/client_model.dart';
import '../../values/firebase_auth_constants.dart';
import '../../values/image_routes.dart';
import '../components/component_text_input.dart';
import '../components/constants/hn_button.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool isButtonEnabled = false;
String user = '';
String password = '';

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    final topBackground = Container(
      height: _height * 0.55,
      width: _width,
      color: CustomColors.redGrayLightSecondaryColor,
    );

    return Scaffold(
      backgroundColor: CustomColors.redPrimaryColor,
      body: Stack(
        children: [
          topBackground,
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: _height * 0.1),
                child: Image.asset(ImageRoutes.getRoute('ic_logo'),
                    width: _width * 0.75),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: const BoxDecoration(
                color: CustomColors.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(16)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26, //CustomColor.shadowColor,
                      blurRadius: 16.0,
                      spreadRadius: 1.0,
                      offset: Offset(0.0, 5.0)),
                ],
              ),
              margin: EdgeInsets.only(left: 24.0, right: 24.0, top: _height * 0.4),
              width: double.infinity,
              child: Form(
                child: Column(
                  children: <Widget>[
                    HNComponentTextInput(
                      labelText: 'Correo',
                      textInputType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      onChange: (text) {
                        user = text;
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    HNComponentTextInput(
                      labelText: 'Contraseña',
                      textCapitalization: TextCapitalization.none,
                      obscureText: true,
                      onChange: (text) {
                        password = text;
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    HNButton(ButtonTypes.redWhiteBoldRoundedButton)
                        .getTypedButton("ACCEDER", null, null,
                            getIsButtonEnabled() ? signIn : null, null),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool getIsButtonEnabled() {
    if (user != '' && password != '') {
      return true;
    } else {
      return false;
    }
  }

  navigateToMainPage(ClientModel clientModel) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomePage(clientModel)),
        (route) => false);
  }

  Future<ClientModel?>? getUserInfo() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseUtils.instance.getUserFromUid(uid!);
    if (querySnapshot.docs.isNotEmpty) {
      String id = querySnapshot.docs[0].id;
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('client_info')
          .doc(id)
          .get();

      if (document.exists) {
        final Map<String, dynamic>? userInfo =
            document.data() as Map<String, dynamic>?;
        if (userInfo != null) {
          userInfo['document_id'] = document.id;
          return ClientModel.fromMap(userInfo);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future signIn() async {
    try {
      showDialog(
          context: context,
          builder: (_) => const Center(child: CircularProgressIndicator()));

      developer.log('Empieza la función signInWithEmailAndPassword()',
          name: 'Login');
      // TODO: Esto va muy lento - investigar
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user.trim(), password: password);
      developer.log('Función signInWithEmailAndPassword() terminada',
          name: 'Login');
      developer.log('Empieza la función getUserInfo()', name: 'Login');
      ClientModel? currentUser = await getUserInfo();
      developer.log('Función getUserInfo() terminada', name: 'Login');
      if (currentUser != null) {
        navigateToMainPage(currentUser);
      } else {
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                        'El usuario y/o contraseña no son correctas. Por favor, revise los datos e inténtelo de nuevo.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('De acuerdo.'),
                        onPressed: () {
                          setState(() {
                            // TODO: borrar contraseña
                          });
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ));
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage =
          '${FirebaseAuthConstants.genericError} Código de error: ${e.code}';
      if (FirebaseAuthConstants.loginErrors.containsKey(e.code)) {
        errorMessage = FirebaseAuthConstants.loginErrors[e.code] ?? "";
      }

      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text('Vaya...'),
                content: Text(errorMessage),
                actions: <Widget>[
                  TextButton(
                    child: const Text('De acuerdo.'),
                    onPressed: () {
                      setState(() {
                        // TODO: borrar contraseña
                      });
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    }
  }
}
