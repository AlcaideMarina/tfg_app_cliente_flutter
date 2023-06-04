import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

    return Scaffold(
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
              width: double.infinity,
              child: Form(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 96,
                    ),
                    Image.asset(ImageRoutes.getRoute('ic_logo'),
                        width: 218, height: 287),
                    const SizedBox(
                      height: 48,
                    ),
                    // TODO: Esto será el usuario, no el correo
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
                      height: 24,
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
                      height: 24,
                    ),
                    const SizedBox(height: 56)
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          margin: const EdgeInsets.all(24),
          child: HNButton(ButtonTypes.redWhiteBoldRoundedButton).getTypedButton(
              "ACCEDER",
              null,
              null,
              getIsButtonEnabled() ? signIn : null,
              null),
        ));
  }

  bool getIsButtonEnabled() {
    if (user != '' && password != '') {
      return true;
    } else {
      return false;
    }
  }

  navigateToMainPage(ClientModel clientModel) {
    // TODO: Evitar que al dar al botón de atrás, vuelva aquí - investigar
    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(
        builder: (_) => HomePage(clientModel)
      ), 
      (route) => false);
  }

  // TODO: Esto debería estar en una clase aparte
  Future<ClientModel?>? getUserInfo() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseUtils.instance.getUserFromUid(uid!);
    // TODO: Comprobar que sea un cliente
    if (querySnapshot.docs.isNotEmpty) {
      String id = querySnapshot.docs[0].id;
      DocumentSnapshot document =
          await FirebaseFirestore.instance.collection('client_info').doc(id).get();

      if (document.exists) {
        final Map<String, dynamic>? userInfo = document.data() as Map<String, dynamic>?;
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
    // TODO: añadir un Circular Progress Indicator - que no se pueda quitar
    // TODO: hacer un componente de pop-up
    // TODO: Fix - si hay algún error, no se quita el circular progress indicator
    try {
      showDialog(
        context: context, 
        builder: (_) => const Center(
          child: CircularProgressIndicator()));

      developer.log('Empieza la función signInWithEmailAndPassword()', name: 'Login');
      // TODO: Esto va muy lento - investigar
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.trim(), password: password);
      developer.log('Función signInWithEmailAndPassword() terminada', name: 'Login');
      developer.log('Empieza la función getUserInfo()', name: 'Login');
      ClientModel? currentUser = await getUserInfo();
      developer.log('Función getUserInfo() terminada', name: 'Login');
      if (currentUser != null) {
        navigateToMainPage(currentUser);
      } else {
        
      showDialog(context: context, builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: const Text('El usuario y/o contraseña no son correctas. Por favor, revise los datos e inténtelo de nuevo.'),
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
