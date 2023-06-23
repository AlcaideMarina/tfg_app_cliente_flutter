import 'package:flutter/material.dart';

import '../../custom/app_theme.dart';
import '../../custom/custom_colors.dart';
import '../../firebase/firebase_utils.dart';
import '../../model/client_model.dart';
import '../components/component_simple_form.dart';
import '../components/component_text_input.dart';
import '../components/constants/hn_button.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage(this.clientModel, {Key? key}) : super(key: key);

  final ClientModel clientModel;

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late ClientModel clientModel;

  @override
  void initState() {
    super.initState();
    clientModel = widget.clientModel;
  }

  String oldPass = "";
  String newPass1 = "";
  String newPass2 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: CustomColors.whiteColor,
            ),
            toolbarHeight: 56.0,
            title: const Text(
              'Cambiar contraseña',
              style: TextStyle(fontSize: 18),
            )),
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getComponentSimpleForm(
                          'Contraseña actual', null, TextInputType.text,
                          (value) {
                        oldPass = value;
                      }),
                      getComponentSimpleForm(
                          'Nueva contraseña', null, TextInputType.text,
                          (value) {
                        newPass1 = value;
                      }),
                      getComponentSimpleForm('Repita la nueva contraseña', null,
                          TextInputType.text, (value) {
                        newPass2 = value;
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      getButtonsComponent(),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                )),
          ),
        ));
  }

  Widget getComponentSimpleForm(String label, String? labelInputText,
      TextInputType textInputType, Function(String)? onChange,
      {TextCapitalization textCapitalization = TextCapitalization.sentences}) {
    double topMargin = 4;
    double bottomMargin = 4;

    return HNComponentSimpleForm(
      label + ':',
      8,
      40,
      const EdgeInsets.symmetric(horizontal: 16),
      EdgeInsets.only(top: topMargin, bottom: bottomMargin),
      componentTextInput: HNComponentTextInput(
        textCapitalization: textCapitalization,
        labelText: labelInputText,
        obscureText: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textInputType: textInputType,
        onChange: onChange,
      ),
    );
  }

  Widget getButtonsComponent() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: HNButton(ButtonTypes.redWhiteBoldRoundedButton).getTypedButton(
          'Cambiar contraseña', null, null, updatePassword, () {}),
    );
  }

  updatePassword() async {
    FocusManager.instance.primaryFocus?.unfocus();
    showAlertDialog(context);

    if (oldPass != "" && newPass1 != "" && newPass2 != null) {
      if (newPass1 == newPass2) {
        bool? firebaseAuthConf =
            await FirebaseUtils.instance.changePassword(oldPass, newPass1);
        if (firebaseAuthConf == true) {
          if (context.mounted) {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: const Text('Contraseña actualizada'),
                      content: const Text(
                          'La información se ha actualizado correctamente. A partir de ahora, cuando inicie sesión, hágalo con la nueva contraseña.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('De acuerdo.'),
                          onPressed: () {
                            Navigator.of(context)
                              ..pop()
                              ..pop();
                          },
                        )
                      ],
                    ));
          }
        } else {
          if (context.mounted) {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text(
                          'Se ha producido un error cuando se estaban actualizado los datos. Recuerde que la contraseña debe tener, al menos, 6 caracteres. Por favor, revise los datos e inténtelo de nuevo.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('De acuerdo.'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ));
          }
        }
      } else {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text('Las contraseñas no coinciden'),
                  content: const Text(
                      'El campo de repetición de contraseña debe ser exactamente igual que el de "Nuevva contraseña". Por favor, revise los datos e inténtelo de nuevo.'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('De acuerdo.'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      }
    } else {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text('Formulario incompleto'),
                content: const Text(
                    'Debe rellenar todos los campos que se muestran. Por favor, revise los datos e inténtelo de nuevo.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('De acuerdo.'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    }
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
